import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:litebite/app_theme.dart';
import 'package:litebite/cart.dart';
import 'package:litebite/favourite.dart';
import 'package:litebite/home.dart';
import 'package:litebite/menu.dart';
import 'package:litebite/profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  int selectedIndex = 0;

  // All Screens
  final List<Widget> screens = [
      Home(),       
      Menu(),
      Cart(),
      Favourite(),
      Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: cream,
      // Screen
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: cream,
        color: orange,
        buttonBackgroundColor: orange,

        items: const [

          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Home',
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.menu_rounded, color: Colors.white),
            label: 'Menu',
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
            label: 'Cart',
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.favorite_border, color: Colors.white),
            label: 'Favourite',
          ),

          CurvedNavigationBarItem(
            child: Icon(Icons.perm_identity, color: Colors.white),
            label: 'Profile',
          ),
        ],

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

 