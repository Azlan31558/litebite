import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litebite/app_theme.dart';
import 'package:litebite/cart.dart';

class Detail extends StatefulWidget {
  String name,image,nameb,namec,price;
    Detail({super.key,required this.name,required this.image,required this.nameb,required this.namec,required this.price});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int count=1;
    Future getcart() async{
    var res = await http.post(Uri.parse('https://devtechnical.com/AllUser/cart.php'),
    body: {
      'name':widget.name,
      "image":widget.image,
      'type':'',
      'price':widget.price,
      "count": count.toString()
    }
    );
     Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
          
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
      backgroundColor: cream,
        leading: const BackButton(color: dark),
        actions: [const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.favorite_border,color: orange),
        ),const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.share,color: dark),
        )],
      ),
      body: Column(
        children: [
          Image.network(widget.image,height: 250,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.name,style: const TextStyle(fontSize: 19,color: dark,fontWeight: FontWeight.w700),),
                    Text("PKR ${widget.price}",style: const TextStyle(fontSize: 19,color: orange,fontWeight: FontWeight.bold),),
                  ],
                ),
                Text(widget.nameb,style: const TextStyle(fontSize: 16,color: grey,fontWeight: FontWeight.w500),),
                Text(widget.namec,style: const TextStyle(fontSize: 16,color: grey,fontWeight: FontWeight.w500),),
           
          Divider(height: 1,color: border,),
          Text("Wavy BBQ Bite",style: const TextStyle(fontSize: 19,color: dark,fontWeight: FontWeight.w500),),
          Container(
            height: 100,
            child: ListView.builder(itemCount: 4,scrollDirection: Axis.horizontal,itemBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: border),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              Text("Small",style: const TextStyle(fontSize: 16,color: dark,fontWeight: FontWeight.w500),),
              Text("Rs 170",style: const TextStyle(fontSize: 14,color: orange,fontWeight: FontWeight.w500),),
              
                  ],
                ),
              ),
            )),
          ),
          SizedBox(height: 10,),
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: border)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                   if (count>1) {
                      setState(() {
                      count--;
                    });
                   }
                  },
                  child: Container(
                  height: 40,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: cream
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Icon(Icons.minimize,color: dark,),
                  )),
                ),
              Text(count.toString(),style: const TextStyle(fontSize: 19,color: dark,fontWeight: FontWeight.w500),),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: orange
                    ),
                    child: Icon(Icons.add,color: Colors.white,)),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Divider(height: 1,color: border,),
          Row(
            spacing: 16,
            children: [
              Text('Add-ons',style: TextStyle(fontSize: 19,color: dark),),
              Text('(Optional)',style: TextStyle(fontSize: 14,color: grey),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(Icons.check_box_outline_blank,color: grey,),
                  Text("Extra Cheese",style: TextStyle(fontSize: 16,color: dark),),
                ],
              ),
              Text("+PKR 40",style: TextStyle(fontSize: 16,color: orange),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(Icons.check_box_outline_blank,color: grey,),
                  Text("Extra Cheese",style: TextStyle(fontSize: 16,color: dark),),
                ],
              ),
              Text("+PKR 40",style: TextStyle(fontSize: 16,color: orange),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(Icons.check_box_outline_blank,color: grey,),
                  Text("Extra Cheese",style: TextStyle(fontSize: 16,color: dark),),
                ],
              ),
              Text("+PKR 40",style: TextStyle(fontSize: 16,color: orange),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(Icons.check_box_outline_blank,color: grey,),
                  Text("Extra Cheese",style: TextStyle(fontSize: 16,color: dark),),
                ],
              ),
              Text("+PKR 40",style: TextStyle(fontSize: 16,color: orange),),
            ],
          ),                    
             ],
            ),
          ),
          GestureDetector(
            onTap: () {
              getcart();
               },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                border: Border.all(color: orange),
                boxShadow: [BoxShadow(
                  offset: Offset(0, 4),
                  color: orange.withValues(alpha: 0.18),
                  blurRadius: 12
                )],
                borderRadius: BorderRadius.circular(18),
                color: orange
              ),
              child: Row(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart,size: 28,color: Colors.white,),
                  Text("Add to Cart",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.white,
                  ),
                  Text("PKR 220",style: TextStyle(fontSize: 15,color: Colors.white),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}