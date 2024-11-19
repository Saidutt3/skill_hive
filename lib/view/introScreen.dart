import 'package:flutter/material.dart';
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
              Text(
                "SkillHive",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Freelance Services. On Demand.",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildServiceCard("Find a Service", Icons.search,
                      "I'm looking for talented people to work with"),
                  SizedBox(width: 10),
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
                gradientTextButton(
                    "Skip",
                    () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Homepage()),
                        )),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      width: 150,
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          SizedBox(height: 8),
          Text(title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget gradientTextButton(String text, VoidCallback onPressed) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
