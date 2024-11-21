import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:skill_hive/CartScreen.dart';
import 'package:skill_hive/NotificationScreen.dart';
import 'package:skill_hive/model/logo_card_model.dart';
import 'package:skill_hive/model/whishlist_mode.dart';
import 'package:skill_hive/view/LogoScreen/card_details.dart';
import 'package:skill_hive/view/get_inspired.dart';

import 'package:skill_hive/view/homeScreen/Widget/service_category.dart';
import 'package:skill_hive/view/profileScreen.dart';
import 'package:skill_hive/whishlist.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  // final List<Service> services = [
  //   Service(
  //     isFavorite: "false",
  //     imageUrl: 'assets/image1.jpg',
  //     avatarUrl: 'https://via.placeholder.com/50',
  //     title: "Web App UI/UX design for your business",
  //     price: "From \$150",
  //   ),
  //   Service(
  //     isFavorite: "false",
  //     imageUrl: 'assets/image2.jpg',
  //     avatarUrl: 'https://via.placeholder.com/50',
  //     title: "Mobile App UI/UX design for your business",
  //     price: "From \$120",
  //   ),
  //   Service(
  //     isFavorite: "false",
  //     imageUrl: 'assets/image3.jpg',
  //     avatarUrl: 'https://via.placeholder.com/50',
  //     title: "E-commerce Platform UI/UX Design",
  //     price: "From \$200",
  //   ),
  //   Service(
  //     isFavorite: "false",
  //     imageUrl: 'assets/image4.jpg',
  //     avatarUrl: 'https://via.placeholder.com/50',
  //     title: "Landing Page UI Design",
  //     price: "From \$100",
  //   ),
  //   Service(
  //     isFavorite: "false",
  //     imageUrl: 'assets/image5.jpg',
  //     avatarUrl: 'https://via.placeholder.com/50',
  //     title: "Dashboard UI Design for Analytics",
  //     price: "From \$180",
  //   ),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String? username;

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      setState(() {
        username = userDoc['username'];
      });
    }
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Static gradient header
          Container(
            padding: const EdgeInsets.only(top: 110, left: 30),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 280,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username != null
                                ? "Hello, $username 👋🏻"
                                : "Hello 👋🏻",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Let's find the best talent for you",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black45,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()),
                        );
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.white,
                              width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, right: 30, bottom: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search service",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Scrollable content area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Popular Service",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ServiceCategory()),
                                );
                              },
                              child: Text("See All"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(logoData.length, (index) {
                              final service = logoData[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 10.0,
                                          offset: Offset(5, 5)),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MobileAppDevelopmentPage(
                                                        logoDataModel:
                                                            logoData[index],
                                                      )),
                                            );
                                          },
                                          child: Image.asset(
                                            service.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const CircleAvatar(
                                          backgroundImage: NetworkImage(""),
                                        ),
                                        title: Text(logoData[index].title,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        subtitle: Text(
                                            "From \u20B9${logoData[index].price1}",
                                            style: const TextStyle(
                                                color: Colors.white70)),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              // Toggle the isFavorite value
                                              if (logoData[index].isFavorite ==
                                                  "true") {
                                                logoData[index].isFavorite =
                                                    "false";
                                                wishlistItems.removeWhere(
                                                    (item) =>
                                                        item.title ==
                                                        logoData[index].title);
                                              } else {
                                                logoData[index].isFavorite =
                                                    "true";
                                                wishlistItems.add(
                                                  WhishlistMode(
                                                    imageUrl: logoData[index]
                                                        .imageUrl,
                                                    title:
                                                        logoData[index].title,
                                                    description: logoData[index]
                                                        .description,
                                                    isLiked: logoData[index]
                                                        .isFavorite,
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            color: logoData[index].isFavorite ==
                                                    "true"
                                                ? Colors.red
                                                : Colors.white54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),

//Get Inspired Container
//Add this code below the Popular Service section

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                GetInspired(), // Replace with your desired screen
                          ),
                        );
                      },
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/GetInspired.jpg'), // Replace with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: const Text(
                            "Explore beautiful work,\npicked for you",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 8.0,
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Top Seller
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Top Sellers",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            return const Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://via.placeholder.com/100'),
                                ),
                                SizedBox(height: 8),
                                Text("Seller Name",
                                    style: TextStyle(color: Colors.white)),
                                Text("Level 2 Seller",
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 12)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 20),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 20),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 20),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true,
        labels: const [
          "Home",
          "Dashboard",

          "Wishlist",
          "Manage Orders", // New tab added here
          "Profile"
        ],
        icons: const [
          Icons.dashboard,
          Icons.favorite,
          Icons.shopping_cart,
          Icons.manage_accounts, // Icon for Manage Orders
          Icons.people_alt,
        ],
        badges: [
          const MotionBadgeWidget(
            textColor: Colors.white,
            color: Colors.red,
            size: 18,
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(2),
          ),
          null,
          null, // No badge for Manage Orders
          const MotionBadgeWidget(
            isIndicator: true,
            color: Colors.red,
            size: 5,
            show: true,
          ),
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.black,
        onTabItemSelected: (int value) {
          setState(() {
            switch (value) {
              case 0:
                // Dashboard or Home
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Homepage(),
                  ),
                );
                break;
              case 1:
                // Wishlist
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Wishlist(), // Replace with your Wishlist screen
                  ),
                );
                break;
              case 2:
                // Cart
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CartScreen(), // Replace with your Cart screen
                  ),
                );
                break;
              case 3:
              // Manage Orders
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         // ManageOrdersScreen(), // Replace with your Manage Orders screen
              //   ),
              // );
              // break;
              case 4:
                // Profile
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProfileScreen(), // Replace with your Profile screen
                  ),
                );
                break;
            }
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}

class Service {
  final String imageUrl;
  final String avatarUrl;
  final String title;
  final String price;
  String isFavorite;

  Service({
    required this.imageUrl,
    required this.avatarUrl,
    required this.title,
    required this.price,
    required this.isFavorite,
  });
}
