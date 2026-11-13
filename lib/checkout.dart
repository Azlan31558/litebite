import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litebite/app_theme.dart';

class Checkout extends StatefulWidget {
  dynamic listdata;

   Checkout({super.key,required this.listdata});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController name= TextEditingController();
  TextEditingController phno= TextEditingController();
  TextEditingController address= TextEditingController();
  Future checkout() async{
    var res = await http.post(Uri.parse('https://devtechnical.com/AllUser/checkbite.php'),
    body: {
      'name':name.text,
      'phno':phno.text,
      'address':address.text,
      'listdata':jsonEncode(widget.listdata)
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: dark),
      backgroundColor: cream,
      title: const Text("Checkout",style: TextStyle(color: dark,fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(        
          spacing: 15,
          children: [
            Text("Delivery Address",style: TextStyle(color: dark,fontWeight: FontWeight.bold,fontSize: 19),),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
            color: surface,
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextFormField(
              style: TextStyle(color: dark),
              controller: name,
        decoration: InputDecoration(
          hintText: "Name",
          hintStyle: TextStyle(color: grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
            ),
          ),),
        ),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
            color: surface,
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextFormField(
              style: TextStyle(color: dark),
              controller: phno,
        decoration: InputDecoration(
          hintText: "Phno",
          hintStyle: TextStyle(color: grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
            ),
          ),),
        ),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
            color: surface,
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextFormField(
              style: TextStyle(color: dark),
              controller: address,
        decoration: InputDecoration(
          hintText: "Address",
          hintStyle: TextStyle(color: grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
            ),
          ),),
        ),
            Text("Payment Method",style: TextStyle(color: dark,fontWeight: FontWeight.bold,fontSize: 19),),
Container(
  height: 65,
  width: MediaQuery.of(context).size.width*0.9,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: orange)
    ,color: surface,
  ),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              Text("Cash on Delivery",style: TextStyle(color: dark,fontWeight: FontWeight.bold,fontSize: 17),),
              Text("Pay when you receive your order",style: TextStyle(color: grey,),),
    
      ],
    ),
  ),
),
SizedBox(height: 50,),
GestureDetector(
  onTap: () {
    checkout();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Placed Order")));
   },
  child: Container(
    height: 45,
    width: MediaQuery.of(context).size.width*0.9,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: orange,
    ),
    child: Center(child: Text("Place Order",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),)),
  ),
)
          ],
        ),
      ),
    );
  }
}