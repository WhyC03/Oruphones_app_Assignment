import 'package:flutter/material.dart';
import 'package:oruphones_app/auth/screens/auth_screen.dart';
import 'package:oruphones_app/auth/services/auth_service.dart';
import 'package:oruphones_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> checkLoginStatus() async {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final hasUserName = prefs.getString('userName') != null;
      return isLoggedIn && hasUserName;
    }

    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(
            width: size.width,
            height: 70,
            color: Colors.grey.shade200,
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                  width: 70,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                )
              ],
            ),
          ),
          FutureBuilder<bool>(
            future: checkLoginStatus(),
            builder: (context, loginSnapshot) {
              if (loginSnapshot.hasData && loginSnapshot.data == true) {
                return FutureBuilder<String?>(
                  future: AuthService().getUserName(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/03/10/18/mona-lisa.jpg?width=1200&height=900&fit=crop'),
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data!,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(); // Empty container if no name is found
                    }
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width * 0.9,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'Login/ SignUp',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ); // Empty container if user is not logged in
              }
            },
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: size.width * 0.9,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  'Sell Your Phone',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                AuthService().logout(context);
              },
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 10),
                  Text("Logout"),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.45),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 18,
                      ),
                      Text(
                        'How To Buy',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attach_money_outlined,
                        size: 18,
                      ),
                      Text(
                        'How To Sell',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message_outlined,
                        size: 18,
                      ),
                      Text(
                        'FAQ',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                      ),
                      Text(
                        'About Us',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        size: 18,
                      ),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            snapshot.hasData && snapshot.data == true
                                ? Icons.assignment_return_outlined
                                : Icons.menu_book_outlined,
                            size: 18,
                          ),
                          Text(
                            snapshot.hasData && snapshot.data == true
                                ? 'Return Policy'
                                : 'ORU Guide',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      );
                    },
                    future: checkLoginStatus(),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   color: Colors.red,
          //   width: 50,
          //   height: 50,
          // )
        ],
      ),
    );
  }
}
