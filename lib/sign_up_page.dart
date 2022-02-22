import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Regisation',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
                controller: nameController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'User Name',
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: nameController.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            nameController.clear();
                          },
                          child: const Icon(Icons.clear),
                        )
                      : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                )),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: mailController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'User Mail',
                  isDense: true,
                  prefixIcon: const Icon(Icons.mail),
                  suffixIcon: mailController.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            mailController.clear();
                          },
                          child: const Icon(Icons.clear),
                        )
                      : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: phoneController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  isDense: true,
                  hintText: 'User Phone',
                  prefixIcon: const Icon(Icons.phone),
                  suffixIcon: phoneController.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            phoneController.clear();
                          },
                          child: const Icon(Icons.clear),
                        )
                      : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: passwordController,
              obscureText: isVisible,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: 'User password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isVisible = !isVisible;
                      setState(() {});
                    },
                    child: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                UserSingUp();
                saveData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              shape: const StadiumBorder(),
              color: Colors.indigo,
              child: const Text(
                'Submit',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
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

                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));

                    },
                    child: const Text(
                      'Sign in',
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

  void UserSingUp() async {
    //FirebaseAuth auth = FirebaseAuth.instance;
    if (nameController.text.isNotEmpty &&
        mailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: mailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showErroeDialog('The password provided is too weak.');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showErroeDialog('The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        showErroeDialog(e.toString());
        print(e);
      }
    } else {
      showErroeDialog('Please fill all fields');
    }
  }

  showErroeDialog(String errorMsg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Wrining!'.toUpperCase()),
            content: const Text('errorMsg'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("ok"))
            ],
          );
        });
  }

  saveData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('user').doc(mailController.text).set({
      'name': nameController.text,
      'mail': mailController.text,
      'phone': phoneController.text,
      'password': passwordController.text
    });
  }
}
