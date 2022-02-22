import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'stors_pags.dart';
class CartPage extends StatefulWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List items=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
         backgroundColor: Colors.blue.shade400,
        leading: BackButton( onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>StorsPage()));
        },),
        title:Text('Your cart has ${items.length} item(s)',style: const TextStyle(fontSize: 18),),
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
          padding:const EdgeInsets.only(left:6,right:6),
                    child:items.isEmpty?const Center(child: CircularProgressIndicator(
                      color: Colors.white,
                    ),):
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
                                offset:const Offset(2,2)
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                child:Image.network(items[index]['image']),
                                height:185,
                                width: 130,
                                margin:const EdgeInsets.only(left:8,top: 8,bottom: 8),
                                padding:const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              const SizedBox(width: 12,),
                              Expanded(
                                child: Column(               
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[                                    
                                     Text(
                                      items[index]['title'],style:const TextStyle(
                                      fontSize:22,fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),),
                                     const SizedBox(height:5,),
                                     Text('Item:${items[index]['catagory']}',style: const TextStyle(
                                      fontSize:18,fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis),),
                                      const SizedBox(height: 10,),
                                      Text('Quantity:${items[index]['quantity']}',style: const TextStyle(
                                        fontSize: 15,
                                      overflow: TextOverflow.ellipsis),),
                                     const SizedBox(height:15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                        Text('ট ${items[index]['price']}',style:const TextStyle(fontSize: 17)),
                                         const SizedBox(width:8),
                                          MaterialButton(
                                            onPressed: ()async{
                                              FirebaseFirestore firestore =await FirebaseFirestore.instance;
                                              firestore.collection('user_cart').
                                              doc(items[index]['id']).delete();
                                              items.clear();
                                              getCartData();
                                              setState(() {
                                                
                                              });
                                            },
                                          color: Colors.deepPurple,
                                          shape:const StadiumBorder(),
                                          child:const Text('Remove item',style: TextStyle(color: Colors.white),),)
                                        ],
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                    
                  }, separatorBuilder: (contex,index){
                    return const SizedBox(height: 8,);
                  }, itemCount:items.length),)
                         
                       ],
                     )
                  ),
      )
      
    );
  }
  getCartData()async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
     var cartData=await firestore.collection('user_cart').get();
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
         'quantity':doc['quantity'],
 
       };
       items.add(map);
       },
       ); 
       print(items);     
     }
  }
}
 