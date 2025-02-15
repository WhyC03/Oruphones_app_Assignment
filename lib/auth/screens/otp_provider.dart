// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oruphones_app/auth/services/auth_service.dart';

class OtpProvider extends ChangeNotifier {
  int start = 30;
  bool ontap = false;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == 0) {
        _timer?.cancel();
        ontap = false;
      } else {
        start--;
        ontap = true;
      }
      notifyListeners();
    });
  }

  void resetTimer() {
    _timer?.cancel();
    start = 30;
    ontap = false;
    notifyListeners();
    startTimer();
  }

  Future<bool> verifyOtp(
      String phoneNumber, String otp, BuildContext context) async {
    bool isVerified = await AuthService().verifyOtp(phoneNumber, otp, context);
    if (!isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verification failed. Please try again.')),
      );
    }
    return isVerified;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
