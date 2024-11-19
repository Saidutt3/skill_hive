import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class GetInspired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300.0,
          floating: false,
          pinned: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: BubblesPainter(),
                  ),
                ),
                Container(
                  height: 350,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 32.0),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Spark your \n next idea',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 12),
                        Center(
                          child: Text(
                            '           Explore beautiful work, \n made on skill hive, picked for you.',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[300]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryButton('All'),
                      _buildCategoryButton('Top Trending'),
                      _buildCategoryButton('For You'),
                      _buildCategoryButton('Photography'),
                      _buildCategoryButton('Illustration'),
                      _buildCategoryButton('Video Editing'),
                      _buildCategoryButton('Writing'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GridItem(
                  title: [
                    'Architecture & Interior Design',
                    'Brand Style Guides',
                    'AI Artists'
                  ][index % 3],
                  imagePath: 'assets/image${(index % 5) + 1}.jpg',
                  blurHash: [
                    'LEHV6nWB4pEkJtq8rKjZ8mKQo1gC', // Example blur hash 1
                    'LKO2?U%2Tw=w]~RBVZRi};RPxuwH', // Example blur hash 2
                    'L4YK|7Of0g?bH-|tT-J9]lQKp8Fv', // Example blur hash 3
                  ][index % 3], // Choose blur hash for each item
                );
              },
              childCount: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(String text) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(minWidth: 80, maxWidth: 120), // Responsive width
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16), // Softer corners
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14, // Adjusted font size
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatefulWidget {
  final String title;
  final String imagePath;
  final String blurHash;

  GridItem(
      {required this.title, required this.imagePath, required this.blurHash});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                BlurHash(
                  hash:
                      widget.blurHash, // Use the blur hash for the placeholder
                  imageFit: BoxFit.cover,
                  duration: Duration(milliseconds: 500),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class BubblesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      Colors.pink.withOpacity(0.2),
      Colors.blue.withOpacity(0.2),
      Colors.green.withOpacity(0.2),
      Colors.yellow.withOpacity(0.2),
      Colors.purple.withOpacity(0.2),
    ];

    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = colors[0];
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.4), 50, paint);

    paint.color = colors[1];
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.2), 80, paint);

    paint.color = colors[2];
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.7), 100, paint);

    paint.color = colors[3];
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.8), 40, paint);

    paint.color = colors[4];
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.9), 60, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
