import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/list/datails_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List catagory=['Top item','Almirah','Alna','Chair','Table','Khat','Dechin' ];
  List catagory2=['top item','almirah','alna','chair','table','khat','Dechin' ];
  int Selectedindex = 0;

  List items=[];

  var collectionName='top item';
  
  TextEditingController searchController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData('top item');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
            padding:const EdgeInsets.only(left:14, right: 13, top:10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Best Furniture !',
                  style: TextStyle(fontSize:27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height:5,
                ),
                const Text(
                  'Your Prefect Choice',
                  style: TextStyle(fontSize: 20,fontWeight:FontWeight.normal ),
                ),
                const SizedBox(
                  height:12,
                ),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search here',hintStyle:const TextStyle(color: Colors.black87,fontWeight: FontWeight.normal),
                    suffixIcon:IconButton(onPressed: (){
                      items.clear();
                      getDataBySearch(collectionName);
                    }, icon: const Icon(Icons.search)),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width:1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width:1.0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    border: OutlineInputBorder(
                     borderSide:
                         BorderSide(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
               
                Container(
                  margin:const EdgeInsets.symmetric(vertical:8),
                  height: 40,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width:1,
                        );
                      },
                      itemCount: catagory.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MaterialButton(
                            shape: const StadiumBorder(),
                            onPressed: () {
                              Selectedindex = index;
                              collectionName=catagory2[Selectedindex];
                              items.clear();
                              getData(catagory2[Selectedindex]);
                              setState(() {});
                            },
                            minWidth:90,
                            color: Selectedindex==index?Colors.black:null,
                            child: Text(
                              catagory[index],style: TextStyle(color: Selectedindex==index?Colors.white:Colors.black,fontSize:16),
                            )
                         );
                      }),
                ),
                Expanded(
                  child:items.isEmpty?const Center(child: CircularProgressIndicator(
                    color: Colors.white,
                  ),):
                   ListView.separated(
                    itemBuilder: (contex,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (contex)=> DetailsPage(ptoductDetails: items[index],)));
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal:5,vertical:3),
                          height: 180,
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
                          child: Row(
                            children: [
                              Container(
                                child:Image.network(items[index]['image']),
                                height:200,
                                width: 130,
                                margin:const EdgeInsets.all(8),
                                padding:const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                      
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,                           
                                  children:[
                                     Text(
                                      items[index]['title'],
                                      style:const TextStyle(
                                      fontSize: 22,fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),),
                                     Text('Item:${items[index]['catagory']}',style: const TextStyle(
                                      fontSize:16,fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis),),
                                      const SizedBox(height: 10,),
                                      Text(items[index]['description'],style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),),
                                     const SizedBox(height:30,),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                        Text('ট ${items[index]['price']}',style:const TextStyle(fontSize: 17),),
                                         const SizedBox(width:25),
                                          MaterialButton(
                                            onPressed: (){
                                              addToCard(index: index);
                                              showMassage(msg: 'Succesfull added to cart');
                                            },
                                          color: Colors.deepPurple,
                                          shape:const StadiumBorder(),
                                          child:const Text('Buy now',style: TextStyle(color: Colors.white),),)
                                        ],
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                  
                }, separatorBuilder: (contex,index){
                  return const SizedBox(height:10,);
                }, itemCount:items.length),
                )
              ]
          ),    
         ) 
       ) 
     );
      
  }
getData(String keyWord)async{
FirebaseFirestore firestore = FirebaseFirestore.instance;



var data =await firestore.collection(keyWord).get();
for (var doc in data.docs) {
 setState(() {
    Map map={
    'catagory':doc['catagory'],
    'description':doc['description'],
    'image':doc['image'],
    'price':doc['price'],
    'rating':doc['rating'],
    'title':doc['title'],
  };
  items.add(map);
 });
 print(items);
}
}
getDataBySearch(String CollectionName)async{
 FirebaseFirestore firestore = FirebaseFirestore.instance;
 var data = await firestore.collection(CollectionName).where('title',isEqualTo:searchController.text).get();
 for (var doc in data.docs) {
   setState(() {
     Map map={
    'catagory':doc['catagory'],
    'description':doc['description'],
    'image':doc['image'],
    'price':doc['price'],
    'rating':doc['rating'],
    'title':doc['title'],
     };
     items.add(map);
   });
   print(items);
 }
}
addToCard({required int index}){
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection('user_cart').add( 
    {
      'catagory':items[index]['catagory'],
      'description':items[index]['description'],
      'image':items[index]['image'],
      'price':items[index]['price'],
      'rating':items[index]['rating'],
      'title':items[index]['title'],
      'quantity':1
    }
  );
}
showMassage({required String msg}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: const Text('Waring!',style: TextStyle(fontSize: 20),),
      content: Text(msg),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child:const Text('ok'))
      ],
    );
  });
}
}
