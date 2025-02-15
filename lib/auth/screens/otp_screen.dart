// ignore_for_file: use_build_context_synchronously

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oruphones_app/auth/services/auth_service.dart';
import 'package:oruphones_app/constants.dart';
import 'package:oruphones_app/auth/screens/otp_provider.dart'; // Import OtpProvider

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  OtpScreen({super.key, required this.phoneNumber});

  final TextEditingController pin1Controller = TextEditingController();
  final TextEditingController pin2Controller = TextEditingController();
  final TextEditingController pin3Controller = TextEditingController();
  final TextEditingController pin4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final otpProvider = Provider.of<OtpProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: size.width * 0.675),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 100),
              Center(child: Image.asset('assets/images/Logo.png')),
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Verify Mobile No.',
                  style: TextStyle(
                      color: color1, fontSize: 28, fontWeight: FontWeight.w900),
                ),
              ),
              Center(
                child: Text(
                  'Please enter the 4-digit verification code sent to +91-$phoneNumber via SMS',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildOtpField(context, pin1Controller),
                    _buildOtpField(context, pin2Controller),
                    _buildOtpField(context, pin3Controller),
                    _buildOtpField(context, pin4Controller, isLast: true),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Center(
                  child: Text('Didn’t receive OTP?',
                      style: TextStyle(color: Colors.grey))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: otpProvider.ontap
                        ? () {
                            AuthService().sendOtp(phoneNumber);
                            otpProvider.resetTimer();
                          }
                        : null,
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  Text(" in 0.${otpProvider.start} sec"),
                ],
              ),
              SizedBox(height: 50),
              InkWell(
                onTap: () async {
                  String otp = pin1Controller.text +
                      pin2Controller.text +
                      pin3Controller.text +
                      pin4Controller.text;
                  await otpProvider.verifyOtp(phoneNumber, otp, context);
                },
                child: Container(
                  width: size.width * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                      color: color1, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(BuildContext context, TextEditingController controller,
      {bool isLast = false}) {
    return SizedBox(
      height: 65,
      width: 60,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1 && !isLast) FocusScope.of(context).nextFocus();
          if (value.isEmpty) FocusScope.of(context).previousFocus();
        },
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: TextStyle(color: Colors.grey.shade300),
          border: OutlineInputBorder(),
        ),
        style: Theme.of(context).textTheme.headlineMedium,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
