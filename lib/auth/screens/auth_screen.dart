import 'package:flutter/material.dart';
import 'package:oruphones_app/auth/screens/otp_screen.dart';
import 'package:oruphones_app/auth/services/auth_service.dart';
import 'package:oruphones_app/constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final phoneController = TextEditingController();

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
                      icon: Icon(Icons.close))
                ],
              ),
              SizedBox(height: 100),
              Center(
                  child: Image.asset(
                'assets/images/Logo.png',
              )),
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    color: color1,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Sign In To Continue',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 70),
              Text(
                'Enter Your Phone Number',
                style: TextStyle(fontSize: 18),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '+91',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Mobile Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Icon(Icons.check, size: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('Accept '),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        color: color1,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (phoneController.text.isNotEmpty &&
                      phoneController.text.length == 10) {
                    AuthService().sendOtp(phoneController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(
                          phoneNumber: phoneController.text,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Enter a valid phone number'),
                      ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
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
