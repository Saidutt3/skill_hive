import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:skill_hive/NotificationScreen.dart';
import 'package:skill_hive/view/BecomeSeller.dart';
import 'dart:io';
import 'package:skill_hive/view/get_inspired.dart';
import 'package:skill_hive/whishlist.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: gradientIcon(Icons.notifications, 24),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[800],
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? const Icon(Icons.person,
                                size: 50, color: Colors.white)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  'user name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSectionTitle('Skill Hive'),
                buildListTile(Icons.star, 'Get inspired', context),
                buildListTile(Icons.favorite, 'Saved lists', context),
                // buildListTile(Icons.list, 'My interests'),
                buildListTile(Icons.person_add, 'Invite friends', context),
                // buildSectionTitle('Settings'),
                // buildListTile(Icons.settings, 'Preferences'),
                // buildListTile(Icons.account_circle, 'Account'),
                buildSectionTitle('Resources'),
                buildListTile(Icons.support, 'Support'),
                buildListTile(Icons.info, 'Community and legal'),
                buildListTile(Icons.store, 'Become a seller', context),
              ],
            ),
          ),
        ],
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
            textColor: Colors.white,
            color: Colors.red,
            size: 18,
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(2),
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
        tabBarColor: Colors.black,
        onTabItemSelected: (int value) {
          setState(() {
            _selectedIndex = value;
          });

          if (value == 3) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, [BuildContext? context]) {
    return ListTile(
      leading: gradientIcon(icon, 24),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
      onTap: () {
        if (title == 'Get inspired' && context != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GetInspired(),
            ),
          );
        }
        if (title == 'Become a seller' && context != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BecomeSeller(),
            ),
          );
        }
        if (title == 'Saved lists' && context != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Wishlist(),
            ),
          );
        }
        if (title == 'Invite friends' && context != null) {
          _showInviteFriendsBottomSheet(context);
        }
      },
    );
  }

  void _showInviteFriendsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select app to share',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/share.jpg',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Quick Share',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/whatsapp.jpg',
                        width: 70,
                        height: 70,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'WhatsApp',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/insta.jpg',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Chats',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/google.jpg',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget gradientIcon(IconData icon, double size) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Icon(icon, size: size, color: Colors.white),
    );
  }
}
