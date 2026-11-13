import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litebite/app_theme.dart';
import 'package:litebite/addprod.dart';
import 'package:litebite/detail.dart';

class categdetail extends StatefulWidget {
  String id;
  String name;
  categdetail({super.key, required this.id,required this.name});

  @override
  State<categdetail> createState() => _categdetailState();
}

class _categdetailState extends State<categdetail> {
  int index = 1;
  List data = [];
  Future getdata() async {
    var res = await http.post(
      Uri.parse('https://devtechnical.com/AllUser/categprodbite.php'),
      body: {"id": widget.id},
    );
    var result = jsonDecode(res.body);
    setState(() {
      data = result;
    });
  }

  Future getcart(String name, image, price, type) async {
    var res = await http.post(
      Uri.parse('https://devtechnical.com/AllUser/cart.php'),
      body: {
        'name': name,
        "image": image,
        'type': type,
        'price': price,
        "count": "1",
      },
    );
  }

  Future getfav(String name, image, price) async {
    var res = await http.post(
      Uri.parse('https://devtechnical.com/AllUser/favbite.php'),
      body: {"name": name, "image": image, "price": price},
    );
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
        title: Text(
          widget.name,
          style: const TextStyle(fontWeight: FontWeight.w600, color: dark),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addprod()),
                );
              },
              child: Icon(Icons.add, size: 30, color: orange),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
           
          
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 4),
                        color: Colors.black.withValues(alpha: 0.05),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(14),
                    color: surface,
                    border: Border.all(color: border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detail(
                                name: data[index]['name'],
                                image: data[index]['image'],
                                nameb: data[index]['nameb'],
                                namec: data[index]['namec'],
                                price: data[index]['price'],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(14),
                            child: Image.network(
                              data[index]['image'].toString(),
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['name'],
                              style: const TextStyle(
                                fontSize: 19,
                                color: dark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              data[index]['nameb'],
                              style: const TextStyle(fontSize: 15, color: grey),
                            ),
                            Text(
                              data[index]['namec'],
                              style: const TextStyle(fontSize: 15, color: grey),
                            ),
                            SizedBox(height: 4),
                            Row(
                              spacing: 10,
                              children: [
                                Container(
                                  height: 25,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: orange,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "S",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "M",
                                      style: TextStyle(
                                        color: grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  width: 30,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "L",
                                      style: TextStyle(
                                        color: grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "From PKR ${data[index]['price']}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Added to Favourie')),
                              );
                              getfav(
                                data[index]['name'],
                                data[index]['image'],
                                data[index]['price'],
                              );
                            },
                            child: const Icon(
                              Icons.favorite_border,
                              color: orange,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Added')),
                                );
                                getcart(
                                  data[index]['name'],
                                  data[index]['image'],
                                  data[index]['price'],
                                  '',
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: orange,
                                ),
                                child: Center(
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
