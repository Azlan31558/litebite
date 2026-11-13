import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litebite/app_theme.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List fav=[];

  Future getfav() async{
    var res = await http.post(Uri.parse('https://devtechnical.com/AllUser/favshowbite.php'),);
    var result = jsonDecode(res.body);
    setState(() {
      fav=result;
    });
  }

  Future getcart(String name,image,price,type) async{
    var res = await http.post(Uri.parse('https://devtechnical.com/AllUser/cart.php'),
    body: {
      'name':name,
      "image":image,
      'type':type,
      'price':price,
      "count":"1"
    }
    );
  }
  Future delete(String id, int idx) async{
    var res = await http.post(Uri.parse('https://devtechnical.com/AllUser/delfavbite.php'),
    body: {"id":id}
    );
    setState(() {
      fav.removeAt(idx);
    });
  }

@override
  void initState() {
    // TODO: implement initState
    getfav();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: cream,
      appBar: AppBar(
        
        backgroundColor: cream,
        centerTitle: true,
        iconTheme: const IconThemeData(color: dark),
        leading: Icon(Icons.arrow_back),
        title: const Text("Favourite",style: TextStyle(color: dark,fontSize: 19),),
        actions: [GestureDetector(
          onTap: () {
            getfav();
          },
          child: Icon(Icons.refresh,size: 28,color: dark,))],
      ),
      body: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.count(shrinkWrap: true,childAspectRatio: 0.7,crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,children: List.generate(fav.length, (index)=>
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: border),
                  color: surface,
                 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(14),
                        child: Image.network(fav[index]['image'],height: 125,fit: BoxFit.cover,width: 170,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fav[index]['name'],style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: dark),),
                          Text('Rs. ${fav[index]['price']}',style: const TextStyle(fontSize: 14,color: orange,fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          spacing: 6,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                                          onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added')));
                                    getcart(fav[index]['name'], fav[index]['image'], fav[index]['price'],'');
                                  },
                              child: Container(
                                                  height: 31,
                                                  width: 31,
                              
                                                  decoration: BoxDecoration(
                                                    color: orange,
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                              
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 21,
                                                  ),
                                                ),
                            ),
                            GestureDetector(
                                                          onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted')));
                                    delete(fav[index]['id'], index);
                                   },
                              child: Container(
                              height:35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(21),
                                color: Colors.red
                              ),
                              child: Center(child: Icon(Icons.delete,color: Colors.white,),),
                                                  ),
                            ),
                          ],
                        ),
                      ),
                      
          
                  ],
                ),
              ),
            )
            ),),
          ),
        )
      ],
    ),);
  }
}