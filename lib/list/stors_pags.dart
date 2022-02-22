import 'package:flutter/material.dart';
import 'package:flutter_application_1/list/cart_page.dart';
import 'package:flutter_application_1/list/home_page.dart';
import 'package:flutter_application_1/list/profile_page.dart';
import 'package:flutter_application_1/list/wishlist_page.dart';
class StorsPage extends StatefulWidget {
  const StorsPage({ Key? key, String? user }) : super(key: key);

  @override
  _StorsPageState createState() => _StorsPageState();
}

class _StorsPageState extends State<StorsPage> {
  List pages=[const HomePage(),const WishlistPage(),const CartPage(),const ProfilePage(),];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value){
          index=value;
          setState(() {
            
          });
        },
        type: BottomNavigationBarType.fixed,
        
        items:const [ 
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home Page'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Wishlist'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
      ]),
      
    );
  }
}