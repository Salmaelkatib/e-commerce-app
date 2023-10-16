import 'package:ecommerce_app/pages/cartPage.dart';
import 'package:ecommerce_app/pages/productsPage.dart';
import 'package:ecommerce_app/pages/profilePage.dart';
import 'package:ecommerce_app/pages/signin.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'signinPage',
      routes: {
        'signinPage': (context) => signinPage(),
        'signupPage': (context) => signupPage(),
        'productsPage': (context) => const productsPage(),
        'profilePage': (context) => const profilePage(),
        'cartPage': (context) => const cartPage(),
      },
    );
  }
}
