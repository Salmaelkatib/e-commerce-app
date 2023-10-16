import 'package:ecommerce_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../models/user.dart';
import '../widgets/custom_textfield.dart';

class signupPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _globalKey = GlobalKey<FormBuilderState>();

  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    CustomTextField username, email, password, address;

    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            Column(
              children: [
                const Image(
                  image: AssetImage('images/shoppingicon96.png'),
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 25,
                    color: Colors.blue.shade900,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * .1,
            ),
            username = CustomTextField(
                'Enter your username', Icons.person, userController),
            SizedBox(
              height: height * .02,
            ),
            email = CustomTextField(
                'Enter your email', Icons.email, emailController),
            SizedBox(
              height: height * .02,
            ),
            password = CustomTextField(
                'Enter your password', Icons.lock, passwordController),
            SizedBox(
              height: height * .02,
            ),
            address = CustomTextField(
                'Enter your address', Icons.location_on, addressController),
            SizedBox(
              height: height * .05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.blue.shade900,
                onPressed: () async {
                  _globalKey.currentState?.validate();
                  try {
                    //sign up new user
                    User user = User(
                        username: username.getcontroller().text,
                        email: email.getcontroller().text,
                        password: password.getcontroller().text,
                        address: address.getcontroller().text);
                    Auth().signUp(user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Account created successfully.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Do you have an account?'),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'signinPage',
                    );
                  },
                  child: const Text('Sign in')),
            ])
          ],
        ),
      ),
    );
  }
}
