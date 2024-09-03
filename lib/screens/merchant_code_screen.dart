import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class MerchantCodeScreen extends StatelessWidget {
  const MerchantCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('../assets/menu_live_logo.png', height: 100),
            const SizedBox(height: 20),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please enter the merchant code in order to proceed',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: const OutlineInputBorder(),
                  hintText: '04Z50GGOUP',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'LET\'S GO',
              color: Colors.yellow,
              onPressed: () {
                // Implement merchant code submission
              },
            ),
          ],
        ),
      ),
    );
  }
}
