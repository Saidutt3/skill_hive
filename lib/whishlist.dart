import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  // List of wishlist items
  final List<Map<String, dynamic>> wishlistItems = [
    {
      'title': 'Mobile App UI Design',
      'icon': Icons.phone_android,
    },
    {
      'title': 'E-commerce Platform UI Design',
      'icon': Icons.shopping_cart,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: wishlistItems.isEmpty
          ? Center(
              child: Text(
                'Your Wishlist is empty!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: wishlistItems.length,
                itemBuilder: (context, index) {
                  final item = wishlistItems[index];
                  return Column(
                    children: [
                      _buildCard(
                        context,
                        item['title'],
                        item['icon'],
                        index,
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    int index,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(width: 16),
            // Text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Changed to white
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Click to learn more about this design.',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          Colors.white70, // Changed to white with transparency
                    ),
                  ),
                ],
              ),
            ),
            // Delete button
            IconButton(
              onPressed: () {
                setState(() {
                  wishlistItems.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$title - Removed from Wishlist!'),
                ));
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red, // Red-colored favorite icon
              ),
            ),
          ],
        ),
      ),
    );
  }
}
