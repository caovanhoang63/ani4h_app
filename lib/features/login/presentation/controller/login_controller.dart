import 'package:ani4h_app/features/login/application/ilogin_service.dart';
import 'package:ani4h_app/features/login/application/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  final loginService = ref.watch(loginServiceProvider);
  return LoginController(loginService);
});

class LoginController extends StateNotifier<LoginState> {
  final ILoginService _loginService;
  
  LoginController(this._loginService) : super(const LoginState());
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  
  Future<bool> login() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      
      await _loginService.login(
        emailController.text.trim(),
        passwordController.text,
      );
      
      state = state.copyWith(isLoading: false, isLoggedIn: true);
      print("Logged-in");
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().contains('Invalid credentials')
            ? 'Invalid email or password'
            : 'An error occurred. Please try again.',
      );
      return false;
    }
  }
}

class LoginState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;
  
  const LoginState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.errorMessage,
  });
  
  LoginState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage,
    );
  }
}