// ignore_for_file: prefer_const_constructors

import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/user.dart';
import '../login_page.dart';
import 'stors_pags.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

var name, phone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: user_name);
    phoneController = TextEditingController(text: phone_number);

    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.blue.shade400,
        leading: BackButton( onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>StorsPage()));
        },),
      ),
        body: Container(
          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            colors: [  
                             Colors.indigo,                
                            Colors.deepOrange,
                            Colors.grey,
                            Colors.blue,
                            Colors.amber,                           
                            Colors.teal,                           
                            Colors.amber,                                                                                                                             
                           ]),
                            color: Colors.lightBlue,
                            shape: BoxShape.rectangle,
                            border: Border.all(width:2,color: Colors.white),
                            borderRadius:const BorderRadius.only(topLeft: Radius.circular(40),bottomRight: Radius.circular(60)),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.blueGrey.shade300,
                                blurRadius:4.0,
                                spreadRadius:10,
                                offset: Offset(2,2)
                              )
                            ],
                          ),
      // constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage:AssetImage('assets/images/naim.jpg'),  
            radius: 40,
             
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            color: Colors.green.shade500,
            margin: const EdgeInsets.symmetric(horizontal:14, vertical:8),
            child: Container(
              decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            colors: [  
                            Colors.orange, 
                            Colors.indigo,                
                            Colors.deepOrange,
                            Colors.grey,
                            Colors.lightGreen,
                            Colors.amber,                           
                            Colors.teal,                           
                            Colors.pink,                                                                                                                              
                           ]),
                            color: Colors.lightBlue,
                            shape: BoxShape.rectangle,
                            border: Border.all(width:2,color: Colors.white),
                            borderRadius:const BorderRadius.only(topLeft: Radius.circular(35),bottomRight: Radius.circular(45)),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.blueGrey.shade300,
                                blurRadius:4.0,
                                spreadRadius:10,
                                offset: Offset(2,2)
                              )
                            ],
                          ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.person),
                  const SizedBox(
                    width:15,
                  ),
                  Text(
                    name ?? 'Null data',
                    style: TextStyle(fontSize: 18,color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.green.shade500,
            margin: const EdgeInsets.symmetric(horizontal:14, vertical:8),
            child: Container(
              decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            colors: [  
                            Colors.orange, 
                            Colors.indigo,                
                            Colors.deepOrange,
                            Colors.grey,
                            Colors.lightGreen,
                            Colors.amber,                           
                            Colors.teal,                           
                            Colors.pink,                                                                                                                              
                           ]),
                            color: Colors.lightBlue,
                            shape: BoxShape.rectangle,
                            border: Border.all(width:2,color: Colors.white),
                            borderRadius:const BorderRadius.only(topLeft: Radius.circular(35),bottomRight: Radius.circular(45)),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.blueGrey.shade300,
                                blurRadius:4.0,
                                spreadRadius:10,
                                offset: Offset(2,2)
                              )
                            ],
                          ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Icon(Icons.mail),
                  const SizedBox(
                    width:15,
                  ),
                  Text(
                    email_id ?? 'Null data',
                    style: TextStyle(fontSize: 18,color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.green.shade500,
           margin: const EdgeInsets.symmetric(horizontal:14, vertical:8),
            child: Container(
              decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            colors: [ 
                              Colors.orange, 
                             Colors.indigo,                
                            Colors.deepOrange,
                            Colors.grey,
                            Colors.lightGreen,
                            Colors.amber,                           
                            Colors.teal,                           
                            Colors.pink,                                                                                                                             
                           ]),
                            color: Colors.lightBlue,
                            shape: BoxShape.rectangle,
                            border: Border.all(width:2,color: Colors.white),
                            borderRadius:const BorderRadius.only(topLeft: Radius.circular(35),bottomRight: Radius.circular(45)),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.blueGrey.shade300,
                                blurRadius:4.0,
                                spreadRadius:10,
                                offset: Offset(2,2)
                              )
                            ],
                          ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.phone),
                  const SizedBox(
                    width:15,
                  ),
                  Text(
                    phone ?? 'Null data',
                    style: TextStyle(fontSize: 18,color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height:25,),
          Row(            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                height:40,
                  minWidth: 100,
                  color: Colors.blue.shade400,
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(color: Colors.white,fontSize: 18),
                  )),
              MaterialButton(
                height:40,
                  minWidth: 100,
                  color: Colors.blue.shade400,
                  onPressed: () {
                    editProfile();
                  },
                  child: const Text(
                    'Edit profile',
                    style: TextStyle(color: Colors.white,fontSize: 18),
                  )),
            ],
          )
        ],
      ),
    ));
  }

  getUserData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var userData = await firestore.collection('user').doc(email_id).get();

    email_id = userData['mail'];
    name = userData['name'];
    phone = userData['phone'];
    setState(() {});
    print(email_id);
    print(userData);
  }

  editProfile() {
    showDialog(
      barrierColor: Colors.amber.shade200,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update your profile',style: TextStyle(fontSize:18,color: Colors.black87,fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(icon: Icon(Icons.person)),
              ),
              TextField(
                 
                  controller: phoneController,
                  decoration: InputDecoration(icon: Icon(Icons.phone))),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Ok',style: TextStyle(fontSize: 16),),
              onPressed: () {
                updateProfile();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Cancel',style: TextStyle(fontSize: 16),),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  updateProfile() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('user').doc(email_id).update({
      'name': nameController.text,
      'phone': phoneController.text
    }).then((value) => getUserData());
  }
}