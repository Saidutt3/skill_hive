import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skill_hive/checkout_screen.dart';
import 'package:skill_hive/controller/logocontroller.dart';
import 'package:skill_hive/model/logo_card_model.dart';

class MobileAppDevelopmentPage extends StatefulWidget {
  final LogoDataModel logoDataModel;

  MobileAppDevelopmentPage({super.key, required this.logoDataModel});

  @override
  State<MobileAppDevelopmentPage> createState() =>
      _MobileAppDevelopmentPageState();
}

class _MobileAppDevelopmentPageState extends State<MobileAppDevelopmentPage> {
  int selectedPackageType = 1;

  // Default to Silver Package
  final List<String> allServices = [
    'Functional Android app',
    'Functional IOS App',
    'App design',
    'App submission',
    'App icon',
    'Splash screen',
    'Ad network integration',
    'Include source code',
  ];

  // Get the services for the selected package
  List<String> getSelectedServices() {
    if (selectedPackageType == 1) {
      return [
        'Functional ${widget.logoDataModel.title}',
        'Logo Design ',
        'Responsive design',
      ];
    } else if (selectedPackageType == 2) {
      return [
        'Functional ${widget.logoDataModel.title} ',
        'Logo Design ',
        'Responsive design',
        '${widget.logoDataModel.title} submission',
        'App icon',
        'Splash screen',
      ];
    } else {
      return allServices;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.logoDataModel.title,
          style: const TextStyle(fontSize: 22),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Image Section
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(color: Colors.black),
              child: Image.asset(
                widget.logoDataModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Creator Info Section
            // Creator Details Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/creator_image.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.logoDataModel.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.logoDataModel.skills,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.white),
                    onPressed: () {
                      _showCreatorInfo(context);
                    },
                  ),
                ],
              ),
            ), // Description Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.logoDataModel.heading,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.logoDataModel.description,
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Price Tag Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildPriceTag(
                          context, "\u20B9${widget.logoDataModel.price1}", 1),
                      buildPriceTag(
                          context, "\u20B9${widget.logoDataModel.price2}", 2),
                      buildPriceTag(
                          context, "\u20B9${widget.logoDataModel.price3}", 3),
                    ],
                  ),
                  const Divider(color: Colors.grey, height: 32),

                  // Services Section
                  Text(
                    selectedPackageType == 1
                        ? 'Silver Package Services '
                        : selectedPackageType == 2
                            ? 'Gold Package Services'
                            : 'Platinum Package Services',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...getSelectedServices().map(
                    (service) {
                      return ListTile(
                        leading: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Colors.purpleAccent, Colors.blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(service),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
// Gradient Button
                  buildGradientButton(
                    context,
                  ),
                ],
              ),
            ),
            // My Portfolio Section
            const Text(
              'My Portfolio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Portfolio Grid
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: portfolioItems.length,
              itemBuilder: (context, index) {
                final item = portfolioItems[index];
                return GestureDetector(
                  onTap: () {
                    _showPortfolioBottomSheet(context, item);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreatorInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'About the Creator',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '${widget.logoDataModel.name} is a highly experienced ${widget.logoDataModel.title} with over 5 years of experience in ${widget.logoDataModel.skills} for ${widget.logoDataModel.title}. He specializes in creating tailored solutions to meet client requirements.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPriceTag(BuildContext context, String price, int packageType) {
    bool isSelected = selectedPackageType == packageType;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackageType = packageType; // Update the selected package
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: isSelected
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 247, 245, 248),
                    Color.fromARGB(255, 222, 223, 226)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Colors.purpleAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGradientButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckoutScreen(
              logoDataModel: widget.logoDataModel,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [Colors.purpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Text(
            'Request To Order',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildFeatureRow(BuildContext context, String feature, [String? value]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(feature, style: TextStyle(color: Colors.grey[400])),
        if (value != null)
          Text(value, style: const TextStyle(color: Colors.white)),
        if (value == null)
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Colors.purpleAccent, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: const Icon(Icons.check, color: Colors.white),
          ),
      ],
    ),
  );
}

// Portfolio image list with title and description
final List<Map<String, String>> portfolioItems = [
  {
    'image': 'assets/card_details/image1.jpg',
    'title': 'Project 1',
    'description': 'This is the description of Project 1.',
  },
  {
    'image': 'assets/card_details/image2.jpg',
    'title': 'Project 2',
    'description': 'This is the description of Project 2.',
  },
  {
    'image': 'assets/card_details/image3.jpg',
    'title': 'Project 3',
    'description': 'This is the description of Project 3.',
  },
  {
    'image': 'assets/card_details/image4.jpg',
    'title': 'Project 4',
    'description': 'This is the description of Project 4.',
  },
];

// Show bottom sheet with project details
void _showPortfolioBottomSheet(BuildContext context, Map<String, String> item) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              item['image']!,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            Text(
              item['title']!,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              item['description']!,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    },
  );
}

// Hide the back button using this method when navigating to this page
// void navigateToMobileAppDevelopmentPage(BuildContext context) {
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const MobileAppDevelopmentPage(),
//     ),
//   );
// }
