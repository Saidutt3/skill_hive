import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skill_hive/model/logo_card_model.dart';
import 'package:skill_hive/view/Login_Page.dart';
import 'package:skill_hive/view/SignIn.dart';
import 'package:skill_hive/view/homeScreen/HomePage.dart';
import 'package:video_player/video_player.dart';

class SkillHivePage extends StatefulWidget {
  @override
  _SkillHivePageState createState() => _SkillHivePageState();
}

class _SkillHivePageState extends State<SkillHivePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset("assets/IntroVideo.mp4");

    try {
      await _controller.initialize();
      _controller.setLooping(true);
      _controller.play();
      setState(() {});
    } catch (error) {
      print("Video initialization error: $error");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background video
          Positioned.fill(
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : Container(color: Colors.black),
          ),
          // Dark overlay for contrast
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Branding and Cards
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SkillHive",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Freelance Services. On Demand.",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildServiceCard("Find a Service", Icons.search,
                      "I'm looking for talented people to work with"),
                  const SizedBox(width: 10),
                  buildServiceCard("Selling Services", Icons.edit,
                      "I'd like to offer my services"),
                ],
              ),
            ],
          ),
          // Sign In and Skip options
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                gradientTextButton("Skip", () async {
                  // Function to fetch player data from Firestore
                  Future<void> fetchPlayerData() async {
                    try {
                      QuerySnapshot response = await FirebaseFirestore.instance
                          .collection("sellers")
                          .get();

                      logoData.clear();

                      for (int i = 0; i < response.docs.length; i++) {
                        logoData.add(LogoDataModel(
                            name: response.docs[i]["name"],
                            isFavorite: "true",
                            skills: response.docs[i]["skills"],
                            imageUrl: response.docs[i]["cardImageUrl"],
                            title: response.docs[i]["title"],
                            heading: response.docs[i]["heading"],
                            description: response.docs[i]["description"],
                            price: "3500",
                            price1: response.docs[i]["silverPrice"],
                            price2: response.docs[i]["goldPrice"],
                            price3: response.docs[i]["platinumPrice"],
                            plan: "Plan",
                            planDescription: "planDescription",
                            rating: "rating",
                            reviews: "reviews"));
                      }
                      log(logoData.toString());
                      setState(() {}); // Update the UI after fetching data
                    } catch (e) {
                      print("Error fetching data: $e");
                    }
                  }

                  await fetchPlayerData();

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                }),
                gradientTextButton(
                    "Log In",
                    () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServiceCard(String title, IconData icon, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      width: 150,
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget gradientTextButton(String text, VoidCallback onPressed) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
