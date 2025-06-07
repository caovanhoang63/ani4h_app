import 'package:ani4h_app/common/http_status/status_code.dart';
import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/token/itoken_service.dart';
import 'package:ani4h_app/core/data/remote/token/token_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceInterceptorProvider =
  Provider.family<NetworkServiceInterceptor, Dio>((ref, dio) {
  final tokenService = ref.watch(tokenServiceProvider(dio));
  return NetworkServiceInterceptor(tokenService, dio);
});

final class NetworkServiceInterceptor extends Interceptor {
  final ITokenService _tokenService;
  final Dio _dio;
  NetworkServiceInterceptor(this._tokenService, this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler)  async {
    final accessToken = await _tokenService.getAccessToken();
    options.headers["Content-Type"]= "application/json";
    options.headers["Accept"] = "application/json";
    if (accessToken != null) {
      // options.headers["Authorization"] = "Bearer $accessToken";
      options.headers["Authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJraWQiOiJteS1rZXktaWQiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIzbU1vM2hWR1RFNFZUTSIsImlhdCI6MTc0OTI4MzgwMCwiZXhwIjoxNzQ5Mjg1NjAwLCJpc3MiOiJodHRwczovL2FuaTRoLWF1dGguczMuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbS8iLCJhdWQiOiJteS1hdWRpZW5jZSIsImVtYWlsIjoiYnVpdGhhaWhvYW5nMDRAZ21haWwuY29tIiwic2NvcGUiOiJ1c2VyIn0.d2-30b_U6bhoDj3fZcIHRIJ2wShiQ_knPfa560zwYfsTMZ7ind8QPFQlmtUxJ9oZe7mls76aGJR16wudqKh4aKs4n5z6bmTVzryYcKSonq0ZNqzFdkNf-KAFSjScv-gZJDuCUQd1COMHhULTL_44dt2D8jTz3PbwXVGV_TXTiP80oP48OK9hx6PViwyNIV-d6jQXBZKStlSTyz8w3HjukfmmrBEysuEsBLSXjiCUESWQKZe1C-ocvgti0wwBZRvk4B2XwqviJNWEniCeMGRaNSAnduqIAytiHMUcknCR_Q0q0PYBLqisUIluw8aTSx9XKj42e6_1HwfvOyEdCJsxd8IinWw6UKNOnYQxHox_TM0clM9KfmYNJsCYNSzAkLh8X3foz0JsOnq7JAHvjI_9KytPToKU25TZuv0KZJK-8RSy9kxbBsfHIqvbqltt9fPfjOLzj0UV9Pt7KMH9Thbg8sCMrRdqEW7OQeX0skedIEQSsKzlz076DscLps4LEEUPCisgggNXJfH25lB0wimfAabX772YFk-XZt2FJw8WpzRhaWqFE5nTddDacs8TnAbedjVAivxIR2mGaTc_JLZP2VX-CNct-Pw5icXxzsXYAnQwIBsdktbLah7blWX20WU6rMvqYSwJDqJeHVW5O_futEmrUqpukqzpIG_lxs0IsRs";
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // handle unauthorized error
    if (err.response?.statusCode == unauthorized && err.requestOptions.path != "$authEndPoint/login") {
      final token = await _tokenService.getRefreshToken();

      try {
        final result = await _tokenService.refreshToken(token);

        final accessToken = result.data.accessToken;
        final refreshToken = result.data.refreshToken;

        // save new access token and refresh token
        await _tokenService.saveToken(accessToken, refreshToken);

        final options = err.requestOptions;
        // update request header with new access token
        options.headers["Authorization"] = "Bearer $accessToken";
        // repeat the request with new access token
        return handler.resolve(await _dio.fetch(options));

      } on DioException catch (e) {
        if (e.response?.statusCode == refreshTokenExpired) {
          // remove access token and refresh token
          await _tokenService.clearToken();

          return handler.reject(err);
        }
        // continue to handle error
        return handler.reject(err);
      }
    }
    // continue to handle error
    return handler.reject(err);
  }
}