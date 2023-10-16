import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  User user = User(username: ' ', email: ' ', password: ' ', address: ' ');

  getUserDataFromcached() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String userJson = prefs.getString('user') ?? '';
      user = User.fromJson(jsonDecode(userJson));
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDataFromcached();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Text(user.username,
              style: const TextStyle(
                fontFamily: 'Oswald',
                fontSize: 16,
                color: Colors.black,
              )),
          Text(user.email),
          SizedBox(
            height: height * .01,
          ),
          Text(user.address),
          SizedBox(
            height: height * .6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.blue.shade900,
              onPressed: () async {
                Navigator.pushNamed(
                  context,
                  'signinPage',
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('KeepMeLoggedIn', false);
                // clear cached products in cart
                prefs.remove('cart');
              },
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
