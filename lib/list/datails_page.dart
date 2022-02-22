import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DetailsPage extends StatefulWidget {
  const DetailsPage({ Key? key,required this.ptoductDetails }) : super(key: key);
  final Map ptoductDetails;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int quantity = 1;
   late TextEditingController quantityController;
  bool isSelected=false;
  @override
  Widget build(BuildContext context) {
     quantityController = TextEditingController(text: quantity.toString());
    return Scaffold(
      body:SafeArea(
        child: Container(
          constraints:const BoxConstraints.expand(), 
        child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(onPressed: (){
                Navigator.pop(context);
              },),
              IconButton(onPressed: (){
                isSelected=true;
                addToWishlist();
                showMassage(msg: 'Succesfull added to wishlist');
                isSelected=true;
                setState(() {
                  
                });
              }, icon: Icon(isSelected? Icons.favorite:Icons.favorite_border))
            ],
          ),
          Container(
            child:Image.network(widget.ptoductDetails['image'],height:180,width:300,),
          ),
          Expanded(
            child: Container(
              padding:const EdgeInsets.only(left:15,right:15,top:10,bottom:10),
              decoration:const BoxDecoration(
                gradient:LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            colors:[                                             
                            Colors.deepOrange,
                            Colors.grey,
                            Colors.blue,
                            Colors.brown,                            
                            Colors.brown,                                                      
                            ]),
                 
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(25)
              ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.ptoductDetails['title'] ,
                      style:const TextStyle(fontSize:20,fontWeight: FontWeight.bold,
                      overflow:TextOverflow.ellipsis ),),
                        OutlinedButton(
                        onPressed:null,
                      child:Text(widget.ptoductDetails['rating'],style:const TextStyle(color: Colors.black),),)
                    ],
                  ),
                  Padding(
                    padding:const EdgeInsets.symmetric(
                     vertical:13),
                    child: Text('Catagory:${widget.ptoductDetails['catagory']}'),
                  ),
                  Text(widget.ptoductDetails['description']),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
               const  Text('Quantity:',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                MaterialButton(
                  color: Colors.cyan,
                  shape: const StadiumBorder(),
                  onPressed: (){
                    if (quantity>1) quantity--;
                    setState(() {
                      
                    });
                  },
                child :const Text('-',style: TextStyle(color:Colors.black,fontSize: 25),),),
                Container(
                  width: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value){
                      quantity =int.parse(value);
                      setState(() {
                        
                      });
                    },
                    controller: quantityController, 
                    decoration:const InputDecoration(
                      isDense: true,
                      border:OutlineInputBorder()),
                  ),
                ),
                MaterialButton(
                  shape:const StadiumBorder(),
                  color: Colors.cyan,
                  onPressed: ( ){
                    quantity++;
                    setState(() {
                      
                    });
                  },
                child:const Text("+",style: TextStyle(color:Colors.black,fontSize:18),),)
              ],
            ),
            const Divider(
              thickness: 4.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center   ,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Text('ট${int.parse(widget.ptoductDetails['price'])*quantity}',style:const TextStyle(fontSize: 20),),
                MaterialButton(
                  onPressed: ( ){
                    addToCard();
                    showMassage(msg:'Succesfull added to cart');
                  },
                  shape: StadiumBorder(),
                color: Colors.indigo,
                child: const Text('Buy now',style: TextStyle(color:Colors.white),),)
              ],
            )
                ],
              ),
            ),
          ),
        ],
      ),
        ),
      )
    );
  }

  void addToCard() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('user_cart').add( {
      'catagory':widget.ptoductDetails['catagory'],
      'description':widget.ptoductDetails['description'],
      'image':widget.ptoductDetails['image'], 
      'price':widget.ptoductDetails['price'],
      'rating':widget.ptoductDetails['rating'],
      'title':widget.ptoductDetails['title'],
      'quantity':quantityController.text
 
    });
  }
  
  void addToWishlist() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('wish_list').add( {
      'catagory':widget.ptoductDetails['catagory'],
      'description':widget.ptoductDetails['description'],
      'image':widget.ptoductDetails['image'], 
      'price':widget.ptoductDetails['price'],
      'rating':widget.ptoductDetails['rating'],
      'title':widget.ptoductDetails['title'],
    });
  }
  void showMassage({required String msg}) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(msg),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:const Text('ok'))
        ],
      );
    });
  }


}