import 'dart:convert';
import 'dart:typed_data';

import 'package:ani4h_app/features/main/presentation/ui/main_screen.dart';
import 'package:ani4h_app/features/payment/data/dto/payment_request.dart';
import 'package:ani4h_app/features/payment/presentation/controller/payment_controller.dart';
import 'package:ani4h_app/features/payment/presentation/state/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../core/data/local/secure_storage/secure_storage.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({
    super.key,
  });


  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}
class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  late final PaymentController _controller;
  bool _isLoading = true;
  String? _paymentUrl;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(paymentControllerProvider.notifier);
    _initializePayment();
  }

  Future<void> _initializePayment() async {
    final secureStorage = ref.read(secureStorageProvider);
    final userId = await secureStorage.read("userIdState");
    try {
      final request = PaymentRequest(
        userId: userId!,
        price: 100000,
      );
      
      final response = await _controller.createPayment(request);
      if (response != null) {
        setState(() {
          _paymentUrl = response.data.urlPayment;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error initializing payment: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (_paymentUrl != null)
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(_paymentUrl!),
              ),
              onWebViewCreated: (controller) {
                debugPrint("Payment webview created");
              },
              onLoadStart: (controller, url) {
                debugPrint("Loading URL: ${url?.toString()}");
              },
              onLoadStop: (controller, url) async {
                if (url?.toString().contains("vnp_ReturnUrl") ?? false) {
                  try {
                    final queryParams = url?.queryParameters;
                    if (queryParams != null) {
                      //await _controller.verifyPayment(queryParams);
                      if (mounted) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                            ),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    debugPrint("Error processing payment response: $e");
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Error processing payment. Please try again."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
              onLoadError: (controller, url, code, message) {
                debugPrint("Error loading URL: $message");
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error loading payment page: $message"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
