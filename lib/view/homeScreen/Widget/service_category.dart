// Sample logo data

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:skill_hive/controller/logocontroller.dart';
import 'package:skill_hive/model/logo_card_model.dart';
import 'package:skill_hive/view/LogoScreen/card_details.dart';
import 'package:skill_hive/view/profileScreen.dart';

class ServiceCategory extends StatefulWidget {
  const ServiceCategory({super.key});

  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logo Design', style: TextStyle(fontSize: 22)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.cyanAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hire a designer to create a logo for a new brand or give your existing logo a facelift.',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterChip(
                    label: const Row(
                      children: [
                        Icon(Icons.tune),
                        SizedBox(width: 5),
                        Text("All"),
                      ],
                    ),
                    onSelected: (bool value) {},
                    backgroundColor: Colors.blueGrey[800],
                    selectedColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 15),
                  FilterChip(
                    label: const Text("Style"),
                    onSelected: (bool value) {},
                    backgroundColor: Colors.blueGrey[800],
                    selectedColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 15),
                  FilterChip(
                    label: const Text("Service includes"),
                    onSelected: (bool value) {},
                    backgroundColor: Colors.blueGrey[800],
                    selectedColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 15),
                  FilterChip(
                    label: const Text("Seller Level"),
                    onSelected: (bool value) {},
                    backgroundColor: Colors.blueGrey[800],
                    selectedColor: Colors.blueAccent,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: logoData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Logocontroller.logocontrollervar = index;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MobileAppDevelopmentPage(
                            logoDataModel: logoData[index],
                          ),
                        ),
                      );
                    },
                    child: LogoCard(
                      imageUrl: logoData[index].imageUrl,
                      title: logoData[index].title,
                      // rating: logoData[index]['rating'],
                      // reviews: logoData[index]['reviews'],
                      // price: logoData[index]['price'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true,
        labels: const ["Dashboard", "Home", "Profile", "Settings"],
        icons: const [
          Icons.dashboard,
          Icons.favorite,
          Icons.shopping_cart,
          Icons.people_alt,
        ],
        badges: [
          const MotionBadgeWidget(
            text: '10+',
            textColor: Colors.white,
            color: Colors.red,
            size: 18,
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(2),
            child: const Text(
              '48',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          null,
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
        tabBarColor: Colors.black, // Changed to black
        onTabItemSelected: (int value) {
          setState(() {
            // _selectedIndex = value;
          });

          if (value == 3) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    const ProfileScreen(), // Replace with your custom page widget
              ),
            );
          }
        },
      ),
    );
  }
}

class FilterOptionCard extends StatelessWidget {
  final String title;

  const FilterOptionCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        // //  colors: [Colors.blue, Colors.purple],
        // ),
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.3),
        //     blurRadius: 5,
        //     offset: const Offset(0, 5),
        //   ),
        // ],
      ),
      child: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class LogoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  // final String rating;
  // final String reviews;
  // final String price;

  const LogoCard({
    super.key,
    required this.imageUrl,
    required this.title,
    // required this.rating,
    // required this.reviews,
    // required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(colors: [Colors.black54, Colors.black87]),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      "4.5",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      'From 30 ',
                      style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {}, child: const Icon(Icons.delete)),
                    const SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {}, child: const Icon(Icons.edit)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
