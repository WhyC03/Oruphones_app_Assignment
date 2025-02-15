// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:oruphones_app/auth/services/auth_service.dart';
import 'package:oruphones_app/constants.dart';
import 'package:provider/provider.dart';

class UsernameProvider extends ChangeNotifier {
  final AuthService _userService = AuthService();
  final TextEditingController nameController = TextEditingController();

  UsernameProvider() {
    loadUserName();
  }

  Future<void> loadUserName() async {
    String? savedName = await _userService.getUserName();
    if (savedName != null) {
      nameController.text = savedName;
      notifyListeners();
    }
  }

  Future<void> updateName(BuildContext context) async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      bool success = await _userService.updateUserName(name, context);
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
}

class UsernameScreen extends StatelessWidget {
  const UsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => UsernameProvider(),
      child: Consumer<UsernameProvider>(
        builder: (context, provider, child) {
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
                      child: Image.asset('assets/images/Logo.png'),
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
                        'Write Your Name To Continue',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 70),
                    Text(
                      'Please Tell Us Your Name*',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: provider.nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 60),
                    InkWell(
                      onTap: () => provider.updateName(context),
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
            ),
          );
        },
      ),
    );
  }
}
