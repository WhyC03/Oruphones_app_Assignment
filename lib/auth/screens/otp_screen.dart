import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oruphones_app/auth/services/auth_service.dart';
import 'package:oruphones_app/constants.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Timer timer;
  final TextEditingController pin1Controller = TextEditingController();
  final TextEditingController pin2Controller = TextEditingController();
  final TextEditingController pin3Controller = TextEditingController();
  final TextEditingController pin4Controller = TextEditingController();
  int start = 30;
  bool ontap = false;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          ontap = false;
        });
      } else {
        setState(() {
          start--;
          ontap = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    pin1Controller.dispose();
    pin2Controller.dispose();
    pin3Controller.dispose();
    pin4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 100),
              Center(
                child: Image.asset(
                  'assets/images/Logo.png',
                ),
              ),
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Verify Mobile No.',
                  style: TextStyle(
                    color: color1,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Please enter the 4 digital verification code sent to your mobile number +91-${widget.phoneNumber} via SMS',
                  style: TextStyle(fontSize: 14),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 65,
                      width: 60,
                      child: TextFormField(
                        controller: pin1Controller,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        onSaved: (pin1) {},
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
                    ),
                    SizedBox(
                      height: 65,
                      width: 60,
                      child: TextFormField(
                        controller: pin2Controller,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        onSaved: (pin2) {},
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
                    ),
                    SizedBox(
                      height: 65,
                      width: 60,
                      child: TextFormField(
                        controller: pin3Controller,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        onSaved: (pin3) {},
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
                    ),
                    SizedBox(
                      height: 65,
                      width: 60,
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        controller: pin4Controller,
                        onSaved: (pin4) {},
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: Text(
                'Didn’t receive OTP?',
                style: TextStyle(color: Colors.grey),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ontap
                        ? () {
                            AuthService().sendOtp(widget.phoneNumber);
                            setState(() {
                              start = 30;
                              ontap = false;
                            });
                            startTimer();
                          }
                        : null,
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  Text(
                    " in 0.$start sec",
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  String otp = pin1Controller.text +
                      pin2Controller.text +
                      pin3Controller.text +
                      pin4Controller.text;
                  bool isVerified = await AuthService()
                      .verifyOtp(widget.phoneNumber, otp, context);
                  if (isVerified == false) {
                    // Handle OTP verification failure (e.g., show an error message)
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'OTP verification failed. Please try again.')),
                    );
                  }
                },
                child: Container(
                  width: size.width * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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
}
