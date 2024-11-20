import 'package:flutter/material.dart';
import 'package:skill_hive/controller/logocontroller.dart';
import 'package:skill_hive/model/logo_card_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _paymentMethod = 'card'; // Variable to hold selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Review', style: TextStyle(fontSize: 22)),
        actions: [],
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
        child: ListView(
          children: [
            // Product overview
            Row(
              children: [
                Image.asset(
                  logoData[Logocontroller.logocontrollervar].imageUrl,
                  width: 200,
                  height: 140,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    logoData[Logocontroller.logocontrollervar].title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold), // White text for better contrast
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Payment method selection
            const Text(
              'Add payment method',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // White text
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Custom Radio button with gradient color
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Radio<String>(
                    value: 'card',
                    groupValue: _paymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        _paymentMethod = value;
                      });
                    },
                    activeColor: Colors
                        .transparent, // Keep the radio active color transparent
                    visualDensity:
                        VisualDensity.compact, // Adjust size if necessary
                  ),
                ),
                const Icon(Icons.credit_card,
                    color: Colors.white), // White icon
                const Text('Credit or Debit Card',
                    style: TextStyle(color: Colors.white)), // White text
              ],
            ),
            Row(
              children: [
                // Custom Radio button with gradient color
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Radio<String>(
                    value: 'paypal',
                    groupValue: _paymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        _paymentMethod = value;
                      });
                    },
                    activeColor: Colors
                        .transparent, // Keep the radio active color transparent
                    visualDensity:
                        VisualDensity.compact, // Adjust size if necessary
                  ),
                ),
                Image.network(
                  'https://www.shutterstock.com/shutterstock/photos/2276341185/display_1500/stock-vector-paypal-multinational-financial-technology-payment-company-online-money-transfers-initial-sign-icon-2276341185.jpg',
                  width: 40,
                  height: 30,
                ),
                const Text('  PayPal',
                    style: TextStyle(color: Colors.white)), // White text
              ],
            ),
            const Divider(color: Colors.white), // White divider

            // Order details
            const Text(
              'Order details',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // White text
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.check, color: Colors.green),
              title: const Text('Standard',
                  style: TextStyle(color: Colors.white)), // White text
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Unlimited Revisions',
                      style: TextStyle(color: Colors.white)),
                  Text('3 Number of concepts included',
                      style: TextStyle(color: Colors.white)),
                  Text('Logo transparency',
                      style: TextStyle(color: Colors.white)),
                  Text('Vector file', style: TextStyle(color: Colors.white)),
                  Text('Printable file', style: TextStyle(color: Colors.white)),
                  Text('3D mockup', style: TextStyle(color: Colors.white)),
                  Text('Source file', style: TextStyle(color: Colors.white)),
                ],
              ),
              trailing: const Text('US\$40',
                  style: TextStyle(color: Colors.white)), // White text
            ),
            ListTile(
              leading: const Icon(Icons.check, color: Colors.green),
              title: const Text('Additional logo',
                  style: TextStyle(color: Colors.white)), // White text
              trailing: const Text('US\$5',
                  style: TextStyle(color: Colors.white)), // White text
            ),
            const Divider(color: Colors.white), // White divider

            // Order summary
            const Text(
              'Order summary',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // White text
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Subtotal',
                    style: TextStyle(color: Colors.white)), // White text
                Text('US\$45',
                    style: TextStyle(color: Colors.white)), // White text
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('GST',
                    style: TextStyle(color: Colors.white)), // White text
                Text('US\$9.08',
                    style: TextStyle(color: Colors.white)), // White text
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Service fee',
                    style: TextStyle(color: Colors.white)), // White text
                Text('US\$5.48',
                    style: TextStyle(color: Colors.white)), // White text
              ],
            ),
            const Divider(color: Colors.white), // White divider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Total',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)), // White text
                Text('US\$59.56',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)), // White text
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Delivery date',
                    style: TextStyle(color: Colors.white)), // White text
                Text('Sunday 10 November, 2024',
                    style: TextStyle(color: Colors.white)), // White text
              ],
            ),
            const SizedBox(height: 20),

            // Promo code section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Promo code',
                    style: TextStyle(color: Colors.white)), // White text
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Enter a Code',
                      style: TextStyle(color: Colors.white), // White text
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Add payment method button
            // Add payment method button with gradient background
            Container(
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
                  'Checkout Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckoutScreen(),
  ));
}
