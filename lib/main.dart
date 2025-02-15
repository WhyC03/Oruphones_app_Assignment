import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oruphones_app/auth/screens/auth_screen.dart';
import 'package:oruphones_app/auth/screens/username_screen.dart';
import 'package:oruphones_app/providers/product_provider.dart';
import 'package:oruphones_app/screens/home_screen.dart';
import 'package:oruphones_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:oruphones_app/providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OruPhones App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.white,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => SplashScreen(),
          "/login": (context) => AuthScreen(),
          "/home": (context) => HomeScreen(),
          "/username": (context) => UsernameScreen(),
        },
      ),
    );
  }
}
