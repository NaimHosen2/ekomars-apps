import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/sign_up_page.dart';
import 'package:flutter_application_1/user.dart';
import 'list/stors_pags.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailControll = TextEditingController();
  TextEditingController passwordControll = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login.jpg',
              height: 150,
              width: 200,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Login',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: mailControll,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: 'User Mail',
                prefixIcon: const Icon(Icons.mail),
                suffixIcon: mailControll.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          mailControll.clear();
                        },
                        child: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: passwordControll,
              obscureText: isVisible,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'User Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    isVisible = !isVisible;
                    setState(() {});
                  },
                  child:
                      Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              minWidth: double.infinity,
              height: 50,
              shape: const StadiumBorder(),
              color: Colors.blue,
              onPressed: () {
                userSignIn();
              },
              child: const Text(
                'Log in',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Dont have an account?',
                  style: TextStyle(fontSize: 17),
                ),
                TextButton(
                    onPressed: () {

                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpPage()));

                    },
                    child: const Text(
                      'Create one',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  userSignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: mailControll.text, password: passwordControll.text);

      var user = userCredential.user;
      if (user != null) {
        print(user.uid);
        user_id = user.uid;
        email_id = mailControll.text;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StorsPage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMessage(msg: 'User found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showMessage(msg: 'Wrong password provided for that user');
        print('Wrong password provided for that user.');
      }
    }
  }

  showMessage({required String msg}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ok'),
            )
          ],
        );
      },
    );
  }
}
