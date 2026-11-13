import 'package:flutter/material.dart';
import 'package:litebite/app_theme.dart';
import 'package:litebite/cart.dart';
import 'package:litebite/login.dart';
import 'package:litebite/managprod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = 'User';
  String phone = '+92 000 0000000';

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      username = prefs.getString('username') ?? 'User';
      phone = prefs.getString('phone') ?? '+92 000 0000000';
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: dark),
      backgroundColor: cream,
        title: const Text("Profile",style: TextStyle(fontSize: 19,color: dark,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Column(
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              decoration:  BoxDecoration(
                boxShadow: [BoxShadow(
                  offset:  Offset(0, 4),
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5
                )],
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: border),
                  color: surface,

              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 20,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/azlan.jpeg'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(username,style: const TextStyle(fontSize: 19,color: dark,fontWeight: FontWeight.bold),),
                      Text(phone,style: TextStyle(fontSize: 15,color: grey,fontWeight: FontWeight.w600),),
                      ],
                    )
                  ],
                ),
              ),
            ),
                                SizedBox(height: 30,),

            Container(                
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: border),
                color: surface,
              ),
              child: 
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  spacing: 20,
                  children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (ccontext)=>Cart()));
                            },
                            child: Row(
                              spacing: 20,
                              children: [
                                Icon(Icons.receipt_long_sharp,size: 28,color: orange,),
                                Text('My Orders',style: TextStyle(fontSize: 16,color: dark),),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,color: grey,size: 16,),
                          
                      
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 20,
                            children: [
                              Icon(Icons.wallet,size: 28,color: orange,),
                              Text('Payment Method',style: TextStyle(fontSize: 16,color: dark),),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,color: grey,size: 16,),                                                
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: GestureDetector(
                        onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (ccontext)=>managprod()));
                            },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 20,
                              children: [
                                Icon(Icons.edit,size: 28,color: orange,),
                                Text('Manage Product',style: TextStyle(fontSize: 16,color: dark),),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: grey,size: 16,),                                                
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 20,
                            children: [
                              Icon(Icons.help_outline,size: 28,color: orange,),
                              Text('Help & Support',style: TextStyle(fontSize: 16,color: dark),),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,color: grey,size: 16,),                                                
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 20,
                            children: [
                              Icon(Icons.info,size: 28,color: orange,),
                              Text('About US',style: TextStyle(fontSize: 16,color: dark),),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,color: grey,size: 16,),                                                
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: GestureDetector(
                        onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (ccontext)=>login()));
                            },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 20,
                              children: [
                                Icon(Icons.logout,size: 28,color: orange,),
                                Text('Logout',style: TextStyle(fontSize: 16,color: dark),),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: grey,size: 16,),                                                
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}