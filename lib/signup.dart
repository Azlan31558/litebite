import 'package:flutter/material.dart';
import 'package:litebite/app_theme.dart';
import 'package:litebite/login.dart';
import 'package:litebite/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController username = TextEditingController();
  final TextEditingController phone = TextEditingController();

  Future<void> getuser() async {
    final name = username.text.trim();
    final phoneNumber = phone.text.trim();

    if (name.isEmpty || phoneNumber.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name and phone number')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('phone', phoneNumber);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navbar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 33, 28, 28),
            ),
            Opacity(
              opacity: 0.3,
              child: Image.asset('assets/images/signup.jpg' ,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,),
            ),                               
            Positioned(
              top: 170,
              left: 20,
              right: 20,
              child: Center(
                child: Container(
                  child: Column(
                    spacing: 10,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(25),
                        child: Image.asset('assets/images/liteee.jpeg',height: 107,)),
                      Text("Create Account",style: TextStyle(fontSize: 29,color: Colors.white,fontWeight: FontWeight.bold),),
                      Text("Join Lite Bite for amazing offers",style: TextStyle(fontSize: 19,color: const Color.fromARGB(255, 227, 220, 220),),),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(22),
                   color: Color.fromARGB(195, 1, 14, 30),
                        ),child: 
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 5),
                          child: TextFormField(
                          style: TextStyle(color: Colors.white),                          
                          controller: username,                          
                          decoration: InputDecoration(  
                            fillColor: Colors.transparent,                                                    
                            hintText: "Full Name",
                            hintStyle: TextStyle(color:  const Color.fromARGB(255, 199, 193, 193)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.person,color: const Color.fromARGB(255, 220, 215, 215),)
                          ),
                        ),),
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(22),
                   color: Color.fromARGB(255, 1, 14, 30),
                        ),child: 
                        Center(child: TextFormField(
                          controller: phone,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                               fillColor: Colors.transparent,     
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: const Color.fromARGB(255, 199, 193, 193)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.phone_android,color: const Color.fromARGB(255, 220, 215, 215),)
                          ),
                        ),),
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(19),
                   color: Color.fromARGB(255, 1, 14, 30),
                        ),child: 
                        Center(child: TextFormField(
                           style: TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                               fillColor: Colors.transparent,     
                            hintText: "Email Address",
                            hintStyle: TextStyle(color: const Color.fromARGB(255, 199, 193, 193)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.person,color: const Color.fromARGB(255, 220, 215, 215),)
                          ),
                        ),),
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 58, 58, 58)),
                          borderRadius: BorderRadius.circular(19),
                   color: Color.fromARGB(255, 1, 14, 30),
                        ),child: 
                        Center(child: TextFormField(
 obscureText: false,
                           style: TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                               fillColor: Colors.transparent,     
                            hintText: "Password",
                             hintStyle: TextStyle(color: const Color.fromARGB(255, 199, 193, 193)),
                            suffixIcon: Icon(Icons.visibility_off,color: const Color.fromARGB(255, 206, 200, 200),),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.person,color: const Color.fromARGB(255, 220, 215, 215),)
                          ),
                        ),),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await getuser();
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                              offset: Offset(0, 4),
                              color: const Color.fromARGB(255, 84, 66, 66),
                              blurRadius: 4,
                              spreadRadius: 2
                            )],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(19),
                                           color: orange,
                          ),
                          child: Center(child: Text("Sign Up",style: TextStyle(fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold),))                          
                        ),
                      ),  
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width*0.4-20,
                            color: Colors.grey,
                          ),
                          Container(                            
                            width: 40,
                             child: Text("OR",style: TextStyle(color: Colors.white),),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width*0.4-20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(19),
                   color: Color.fromARGB(255, 1, 14, 30),
                        ),child: 
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 50.0),
                           child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network('https://cdn.iconscout.com/icon/free/png-256/free-google-icon-svg-download-png-1507807.png',height: 30,),
                              Text("Continue with Google",style: TextStyle(fontSize: 16,color: Colors.white),)
                            ],
                           ),
                         )
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(19),
                   color: Color.fromARGB(255, 1, 14, 30),
                        ),child: 
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network('https://static.vecteezy.com/system/resources/thumbnails/018/930/698/small/facebook-logo-facebook-icon-transparent-free-png.png'),
                            Text("Continue with Facebook",style: TextStyle(fontSize: 16,color: Colors.white),)
                          ],
                         )
                      ),
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Text("Already Have an account?",style: TextStyle(fontSize: 16,color: Colors.white),),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (ccontext)=>login()));
                            },
                            child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: const Color(0xFFFFB28F)),)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}