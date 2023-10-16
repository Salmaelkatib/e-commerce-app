import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth.dart';
import '../widgets/custom_textfield.dart';

class signinPage extends StatefulWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  State<signinPage> createState() => _signinPageState();
}

class _signinPageState extends State<signinPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late CustomTextField email, password;
  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: FormBuilder(
      key: widget._globalKey,
      child: ListView(
        children: [
          Column(
            children: [
              const Image(
                image: AssetImage('images/shoppingicon96.png'),
              ),
              Text(
                'E-commerce App',
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
          email =
              CustomTextField('Enter your email', Icons.email, emailController),
          SizedBox(
            height: height * .02,
          ),
          password = CustomTextField(
              'Enter your password', Icons.lock, passwordController),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.blue.shade900),
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue.shade900,
                    value: keepMeLoggedIn,
                    onChanged: (value) {
                      setState(() {
                        keepMeLoggedIn = value!;
                      });
                    },
                  ),
                ),
                const Text('Remember Me')
              ],
            ),
          ),
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
                if (keepMeLoggedIn == true) {
                  keepUserLoggedIn();
                }
                _validate(context);
              },
              child: const Text(
                'Sign in',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: height * .05,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Do not have an account?'),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'signupPage',
                  );
                },
                child: const Text('Sign up')),
          ]),
        ],
      ),
    ));
  }

  Future<void> _validate(BuildContext context) async {
    widget._globalKey.currentState?.validate();
    try {
      String emailValue = email.getcontroller().text;
      String passwordValue = password.getcontroller().text;
      bool success = await Auth().signIn(emailValue, passwordValue);

      if (success) {
        Navigator.pushNamed(context, 'productsPage');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invaild email and/or password'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('KeepMeLoggedIn', keepMeLoggedIn);
  }
}
