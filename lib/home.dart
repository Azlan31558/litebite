import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litebite/categdetail.dart';
import 'package:litebite/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:litebite/app_theme.dart';
import 'package:litebite/menu.dart';
import 'package:litebite/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = "Foodie";
  List data = [];
  List categ = [];

  bool loading = true;
  bool categLoading = true;

  int selectedCategory = 0;
  int selectedNav = 0;

  final TextEditingController searchController = TextEditingController();

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      username = prefs.getString('username') ?? 'Foodie';
    });
  }

  Future<void> getdata() async {
    try {
      var res = await http.post(
        Uri.parse('https://devtechnical.com/AllUser/homebite.php'),
      );

      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);

        if (!mounted) return;

        setState(() {
          data = result;
          loading = false;
        });
      }
    } catch (e) {
      debugPrint("Food API Error: $e");
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> getcateg() async {
    try {
      var res = await http.post(
        Uri.parse('https://devtechnical.com/AllUser/categbite.php'),
      );

      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);

        if (!mounted) return;

        setState(() {
          categ = result;
          categLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Category API Error: $e");
      if (mounted) setState(() => categLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getUsername();
    getdata();
    getcateg();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, $username 👋",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "What would you like to eat today?",
                            style: TextStyle(color: grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },

                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),

                        child: const Icon(
                          Icons.person_outline,
                          color: dark,
                          size: 27,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // LOCATION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: orange, size: 19),

                    const SizedBox(width: 5),

                    const Text(
                      "Deliver to",
                      style: TextStyle(color: grey, fontSize: 12),
                    ),

                    const SizedBox(width: 5),

                    const Text(
                      "Sahiwal, Pakistan",
                      style: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),

                    const Icon(Icons.keyboard_arrow_down, color: orange),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Container(
                  height: 53,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: TextField(
                    controller: searchController,

                    decoration: const InputDecoration(
                      hintText: "Search your favourite food...",
                      hintStyle: TextStyle(color: grey, fontSize: 13),
                      prefixIcon: Icon(Icons.search, color: orange),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                    ),

                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),

              const SizedBox(height: 23),

              // PROMO BANNER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Container(
                  height: 185,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD7B5),
                    borderRadius: BorderRadius.circular(23),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=900',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),

                  child: Container(
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),

                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.78),
                          Colors.black.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Text(
                            "SPECIAL OFFER",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "Delicious Food\nAt Your Doorstep!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Fresh • Tasty • Delivered",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 27),

              // CATEGORY HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Explore Categories",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),

                    Text(
                      "See all",
                      style: TextStyle(
                        color: orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // CATEGORY LIST
              SizedBox(
                height: 115,

                child: categLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: orange),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: categ.length,

                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = index;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => categdetail(
                                    id: categ[index]['id'].toString(),
                                    name: categ[index]['name'].toString(),
                                  ),
                                ),
                              );
                            },

                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                              ),

                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),

                                    height: 72,
                                    width: 72,

                                    padding: const EdgeInsets.all(3),

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedCategory == index
                                          ? orange
                                          : Colors.white,
                                    ),

                                    child: ClipOval(
                                      child: Image.network(
                                        categ[index]['image'],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) {
                                          return const Icon(
                                            Icons.restaurant,
                                            color: orange,
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 7),

                                  Text(
                                    categ[index]['name'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: selectedCategory == index
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: dark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 23),

              // POPULAR FOOD HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Popular Dishes 🔥",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Menu()),
                        );
                      },

                      child: const Text(
                        "View all",
                        style: TextStyle(
                          color: orange,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // FOOD GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),

                child: loading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: CircularProgressIndicator(color: orange),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),

                        itemCount: data.where((item) {
                          String name = item['name'].toString().toLowerCase();

                          return name.contains(
                            searchController.text.toLowerCase(),
                          );
                        }).length,

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 13,
                              childAspectRatio: 0.72,
                            ),

                        itemBuilder: (context, index) {
                          var filtered = data.where((item) {
                            return item['name']
                                .toString()
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase());
                          }).toList();

                          var food = filtered[index];

                          return GestureDetector(
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(19),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.045),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            
                                children: [
                                  // FOOD IMAGE
                                  Expanded(
                                    flex: 6,
                            
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(19),
                                              ),
                            
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Image.network(
                                              food['image'],
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stack) {
                                                    return Container(
                                                      color: cream,
                                                      child: const Icon(
                                                        Icons.fastfood,
                                                        size: 40,
                                                        color: orange,
                                                      ),
                                                    );
                                                  },
                                            ),
                                          ),
                                        ),
                            
                                        Positioned(
                                          top: 9,
                                          right: 9,
                            
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                            
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                            
                                            child: const Icon(
                                              Icons.favorite_border,
                                              size: 17,
                                              color: orange,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            
                                  // FOOD DETAILS
                                  Expanded(
                                    flex: 4,
                            
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                            
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                            
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                            
                                        children: [
                                          Text(
                                            food['name'].toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                            
                                            style: const TextStyle(
                                              color: dark,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                            
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 15,
                                              ),
                                              SizedBox(width: 3),
                                              Text(
                                                "Popular choice",
                                                style: TextStyle(
                                                  color: grey,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                            
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                            
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "Rs. ${food['price']}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: orange,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                            
                                              Container(
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
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 25),

              // BOTTOM OFFER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: const Color(0xFF252525),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Good Food,\nGood Mood! ❤️",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),

                            SizedBox(height: 7),

                            Text(
                              "Order your favourite meal today.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.delivery_dining,
                        color: orange,
                        size: 65,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
