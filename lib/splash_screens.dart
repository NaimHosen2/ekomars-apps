import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';
class SplashScreens extends StatefulWidget {
  const SplashScreens({ Key? key }) : super(key: key);

  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Timer(const Duration(seconds:5), (){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints:const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
           Image.asset(
              'assets/images/chair 2.jpg',
              height:100,
              width:400,
            ),
           const SizedBox(
              height: 15,
            ),
            const Text('Online Furniture Soping',style: TextStyle(
              fontSize: 25,fontWeight: FontWeight.bold,color: Colors.lightBlue),)
          ],
        ),
      ),
      
    );
  }
}