import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/list/stors_pags.dart';
class WishlistPage extends StatefulWidget {
  const WishlistPage({ Key? key }) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List items =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishlistData();
  }
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        leading: BackButton( onPressed: (){ 
          Navigator.push(context, MaterialPageRoute(builder: (context)=>StorsPage()));
        },),
        title:Text('Your wishlist has ${items.length} item(s)',style: const TextStyle(fontSize: 18),),
      ),
      body:SafeArea(
        child: Container(
          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            colors: [  
                                            
                            Colors.deepOrange,
                            Colors.grey,
                            Colors.blue,
                            Colors.brown,                            
                            Colors.grey,                                                      
                            ]),
                            color: Colors.lightBlue,
                            shape: BoxShape.rectangle,
                            border: Border.all(width:2,color: Colors.white),
                            borderRadius:const BorderRadius.only(topLeft: Radius.circular(35),bottomRight: Radius.circular(40)),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.blueGrey.shade300,
                                blurRadius:4.0,
                                spreadRadius:10,
                                offset: Offset(2,2)
                              )
                            ],
                          ),
          padding: const EdgeInsets.only(left:8,right: 8),
                    child:items.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.white,),):
                     Column(
                       children: [
                         
                         const SizedBox(height: 10,), 
                         Expanded(child: 
                         ListView.separated(
                      itemBuilder: (contex,index){
                        return Container(
                          height:180,
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
                          child: Row(
                            children: [
                              Container(
                                child: Image.network(items[index]['image']),
                                height:180,
                                width: 110,
                                margin:const EdgeInsets.all(7),
                                // padding:const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                        
                              ),
                              Expanded(
                                child: Column(               
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[                                                                           
                                         Text(
                                        items[index]['title'],style:const TextStyle(
                                        fontSize: 22,fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.clip),),
                                         const SizedBox(height:5,),
                                     Text('Item:${items[index]['catagory']}',style: const TextStyle(
                                      fontSize:15,fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis),),
                                      const SizedBox(height:12,),
                                      Text('ট ${items[index]['price']}',style:const TextStyle(fontSize: 17)),
                                     const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [                                       
                                        //  const SizedBox(width: 12),
                                          MaterialButton(
                                          color:Colors.green.shade500,
                                          shape: const StadiumBorder(),
                                          onPressed: () async {
                                            addToCart(index);
                                          },
                                          child: const Text(
                                            'Add to Cart',
                                            style: TextStyle(
                                                fontSize:13,
                                                color: Colors.black),
                                          ),
                                        ),
                                        MaterialButton(
                                          color:Colors.green.shade500,
                                          shape: const StadiumBorder(),
                                           child: const Text(
                                            'Remove',
                                            style: TextStyle(
                                                fontSize:13,
                                                color: Colors.black),
                                          ),
                                          onPressed: (){
                                            removeItemFromWishlist(index);
                                          },)
                                        ],
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                    
                  }, separatorBuilder: (contex,index){
                    return const SizedBox(height:5,);
                  }, itemCount:items.length),)
                         
                       ],
                     )
                  ),
      )
      
    );
  }
  getWishlistData()async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
     var cartData=await firestore.collection('wish_list').get();
     for (var doc in cartData.docs) {
       setState(() {
         Map map={
         'catagory': doc['catagory'],
         'description':doc['description'],
         'image':doc['image'],
         'price':doc['price'],
         'rating':doc['rating'],
         'title':doc['title'],
         'id':doc.id,
       };
       items.add(map);
       }); 
       print(items);     
     }
  }
  void addToCart(int index) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('user-cart').add({
      'catagory': items[index]['catagory'],
      'description': items[index]['description'],
      'image': items[index]['image'],
      'price': items[index]['price'],
      'rating': items[index]['rating'],
      'title': items[index]['title'],
      'quantity': items[index]['quantity']
    });
    showMessage(msg: "Successfully added to cart");
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
                  child: const Text('ok'))
            ],
          );
        });
  }

  void removeItemFromWishlist(int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('wish_list').doc(items[index]['id']).delete();
    items.clear();
     getWishlistData();
    setState(() {});
  }
}