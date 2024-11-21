import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:skill_hive/model/logo_card_model.dart';

class BecomeSeller extends StatefulWidget {
  @override
  _BecomeSellerState createState() => _BecomeSellerState();
}

class _BecomeSellerState extends State<BecomeSeller> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _introController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _silverPriceController = TextEditingController();
  final TextEditingController _goldPriceController = TextEditingController();
  final TextEditingController _platinumPriceController =
      TextEditingController();
  final TextEditingController _cardImageUrlController = TextEditingController();

  File? _profileImage;
  List<File> _previousWork = [];

  final ImagePicker _picker = ImagePicker();

  // Pick Profile Picture
  Future<void> _pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Pick Previous Work Files
  Future<void> _pickPreviousWork() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        _previousWork = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  // Save Data to Firestore
  Future<void> _saveDataToFirestore() async {
    try {
      final data = {
        'name': _nameController.text,
        'intro': _introController.text,
        'skills': _skillsController.text,
        'experience': _experienceController.text,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'heading': _headingController.text,
        'silverPrice': _silverPriceController.text,
        'goldPrice': _goldPriceController.text,
        'platinumPrice': _platinumPriceController.text,
        'cardImageUrl': _cardImageUrlController.text,
        'profileImagePath': _profileImage?.path ?? '',
        'previousWork': _previousWork.map((file) => file.path).toList(),
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('sellers').add(data);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data submitted successfully!')),
      );

      // Clear form after successful submission
      _formKey.currentState?.reset();
      _profileImage = null;
      _previousWork.clear();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

// Function to fetch player data from Firestore
  Future<void> fetchPlayerData() async {
    try {
      QuerySnapshot response =
          await FirebaseFirestore.instance.collection("sellers").get();

      logoData.clear();
      for (int i = 0; i < response.docs.length; i++) {
        logoData.add(LogoDataModel(
            name: response.docs[i]["name"],
            isFavorite: "false",
            isCheckout: "false",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Image.asset(
                    'assets/logo.png', // Replace with your logo's path
                    width: 150,
                    height: 150,
                  ),
                ),

                // Profile Picture
                GestureDetector(
                  onTap: _pickProfileImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.add_a_photo,
                            size: 40, color: Colors.purpleAccent)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),

                // Name TextField
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Card Image URL TextField
                TextFormField(
                  controller: _cardImageUrlController,
                  decoration: InputDecoration(
                    labelText: 'Card Image URL',
                    hintText: 'Enter the image URL for your card',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card image URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Title TextField
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter the title for your services',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Heading TextField
                TextFormField(
                  controller: _headingController,
                  decoration: InputDecoration(
                    labelText: 'Heading',
                    hintText: 'Enter the heading for your services',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a heading';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Description TextField
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Provide a description of your services',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Introduction TextField
                TextFormField(
                  controller: _introController,
                  decoration: InputDecoration(
                    labelText: 'Introduction',
                    hintText: 'Write a brief introduction about yourself',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your introduction';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Skills TextField
                TextFormField(
                  controller: _skillsController,
                  decoration: InputDecoration(
                    labelText: 'Skills',
                    hintText: 'What skills do you offer?',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please list your skills';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Experience TextField
                TextFormField(
                  controller: _experienceController,
                  decoration: InputDecoration(
                    labelText: 'Experience',
                    hintText: 'Describe your previous work experience',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe your experience';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Package Prices
                TextFormField(
                  controller: _silverPriceController,
                  decoration: InputDecoration(
                    labelText: 'Silver Package Price',
                    hintText: 'Enter price for Silver Package',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _goldPriceController,
                  decoration: InputDecoration(
                    labelText: 'Gold Package Price',
                    hintText: 'Enter price for Gold Package',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _platinumPriceController,
                  decoration: InputDecoration(
                    labelText: 'Platinum Package Price',
                    hintText: 'Enter price for Platinum Package',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),

                // Upload Previous Work Button
                ElevatedButton(
                  onPressed: _pickPreviousWork,
                  child: const Text("Upload Previous Work"),
                ),
                const SizedBox(height: 10),
                if (_previousWork.isNotEmpty)
                  Wrap(
                    children: _previousWork.map((file) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text(file.uri.pathSegments.last),
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _saveDataToFirestore();
                      log("is fetched");
                      await fetchPlayerData();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submitting form')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
