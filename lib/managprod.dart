import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litebite/app_theme.dart';
import 'package:litebite/addprod.dart';
import 'package:litebite/detail.dart';

class managprod extends StatefulWidget {
  const managprod({super.key});

  @override
  State<managprod> createState() => _managprodState();
}

class _managprodState extends State<managprod> {
  int index = 1;
  List data = [];
  Future getdata() async {
    var res = await http.post(
      Uri.parse('https://devtechnical.com/AllUser/homebitemenu.php'),
    );
    var result = jsonDecode(res.body);
    setState(() {
      data = result;
    });
  }

  Future delete(String id, int idx) async {
    var res = await http.post(
      Uri.parse('https://devtechnical.com/AllUser/delbite.php'),
      body: {"id": id},
    );
    setState(() {
      data.removeAt(idx);
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
        title: const Text(
          "Manage Product",
          style: TextStyle(fontWeight: FontWeight.w600, color: dark),
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
                                        color: Colors.white,
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
                           
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Deleted')),
                                );
                                delete(data[index]['id'], index);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: orange,
                                size: 30,
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
