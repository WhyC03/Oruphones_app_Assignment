// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:oruphones_app/auth/services/auth_service.dart';
import 'package:oruphones_app/constants.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final AuthService userService = AuthService();

    void loadUserName() async {
      String? savedName = await userService.getUserName();
      if (savedName != null) {
        setState(() {
          nameController.text = savedName;
        });
      }
    }

    void updateName() async {
      String name = nameController.text.trim();
      if (name.isNotEmpty) {
        bool success = await userService.updateUserName(name, context);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Name updated successfully!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update name.")),
          );
        }
      }
    }

    @override
    void initState() {
      super.initState();
      loadUserName();
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                'Sign Up To Continue',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 70),
            Text(
              'Please Tell Us Your Name*',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 60),
            InkWell(
              onTap: updateName,
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
                      'Confirm Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
