import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:litebite/app_theme.dart';
import 'package:litebite/checkout.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int count=1;
  bool isloading=true;
  List carts=[];
  Future getdata() async{
    setState(() {
      isloading = false;

    });
    var res = await http.post(Uri.parse('https://devtechnical.com/AllUser/cartbite.php'),);
    var result = jsonDecode(res.body);
    setState(() {
      carts=result;
      isloading=true;
    });
  }

  // clear All
  Future clearcart() async{

    var res = await http.post(Uri.parse('https://devtechnical.com/AllUser/clearcart.php'),);
    setState(() {
      carts.clear();
    });
  }

   Future delete(String id, int idx) async{
    var res = await http.post(Uri.parse('https://devtechnical.com/AllUser/delcartbite.php'),
    body: {"id":id}
    );
    setState(() {
      carts.removeAt(idx);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: dark),
      backgroundColor: cream,
        title: const Text('Your Cart',style: TextStyle(color: dark),),
        actions: [GestureDetector(
          onTap: () {
            clearcart();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Clear All Cart data")));
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("Clear All",style: TextStyle(color: orange,fontWeight: FontWeight.w600),),
          ),
        ),GestureDetector(
          onTap: () {
            getdata();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.refresh,color: dark),
          ))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,   
        children: [
          Container(),
          isloading==false?
           SpinKitWaveSpinner(
    color: orange,
    curve: Curves.bounceInOut,
    size: 100,
)
          :
          Expanded(
           child: ListView.builder(shrinkWrap: true,itemCount: carts.length,itemBuilder: (context,index)=> Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 4),
                      color: Colors.black.withValues(alpha: 0.05)
                    )
                  ],
                  borderRadius: BorderRadius.circular(14),
                  color: surface,
                  border: Border.all(color: border)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Detail()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(14),
                          child: Image.network(carts[index]['image'],height: 100,width: MediaQuery.of(context).size.width*0.3,fit: BoxFit.cover,)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(carts[index]['name'],style: const TextStyle(fontSize: 19,color: dark,fontWeight: FontWeight.w700),),
                          const Text("Medium",style: TextStyle(fontSize: 15,color: grey),),
                          Text("From PKR ${carts[index]['price']}",style: const TextStyle(fontSize: 15,color: orange,fontWeight: FontWeight.w600),),
                           SizedBox(height: 4,),
                          Row(
                            spacing: 10,
                             children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    count--;
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: orange
                                  ),
                                  child: Center(child: Padding(
                                    padding:   EdgeInsets.only(bottom:3.0),
                                    child: Icon(Icons.minimize,color: Colors.white,size: 25,),
                                  ))),
                              ),
                                Text(count.toString(),style: const TextStyle(fontSize: 21,color: dark),),
                                 GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      count++;
                                    });
                                  },
                                   child: Container(
                                                                   height: 25,
                                                                   width: 30,                                
                                                                   decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: orange
                                   ),
                                                                   child: Center(child: Icon(Icons.add,color: Colors.white,size: 21,))),
                                 ),
                            ],
                          ),
                          SizedBox(height: 4,),
                        ],
                      ),
                    ),
                    GestureDetector(
                         onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
                                  delete(carts[index]['id'], index);
                                 },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(child: Icon(Icons.delete,size: 28,color: orange,)),
                      ),
                    ),
                  ],
                ),
              ),
            )),
         ),
         Padding(
           padding: const EdgeInsets.only(bottom: 100.0,left: 10,right: 10),
           child: GestureDetector(
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkout(
                listdata:carts
              )));
            },
             child: Container(
                     height: 45,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: orange
                     ),
                     child: Center(child: Text("Checkout",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),),
                   ),
           ),
         ),
        ],
      ),
     );
  }
}