import 'package:flutter/material.dart';
import 'merchant_code_screen.dart';
import '../widgets/custom_button.dart';

class PrinterSelectionScreen extends StatefulWidget {
  const PrinterSelectionScreen({super.key});

  @override
  _PrinterSelectionScreenState createState() => _PrinterSelectionScreenState();
}

class _PrinterSelectionScreenState extends State<PrinterSelectionScreen> {
  bool isUSBConnected = false;
  int? selectedPaperSize = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('../assets/menulive_icon.png', height: 100),
          const SizedBox(height: 20),
          const Text(
            'Choose Printer Preference!',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: isUSBConnected ? 'USB CONNECTED' : 'CONNECT USB PRINTER',
            color: isUSBConnected ? Colors.green : Colors.white,
            onPressed: () {
              setState(() {
                isUSBConnected = true;
              });
            },
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: 'CONNECT BY PRINTER',
            color: Colors.white,
            onPressed: () {
              // Implement BT connection logic
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Select the paper size',
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<int>(
                value: 2,
                groupValue: selectedPaperSize,
                onChanged: (int? value) {
                  setState(() {
                    selectedPaperSize = value;
                  });
                },
              ),
              const Text('2 inch'),
              Radio<int>(
                value: 3,
                groupValue: selectedPaperSize,
                onChanged: (int? value) {
                  setState(() {
                    selectedPaperSize = value;
                  });
                },
              ),
              const Text('3 inch'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: 'SKIP',
                color: Colors.yellow,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MerchantCodeScreen()),
                  );
                },
              ),
              const SizedBox(width: 20),
              CustomButton(
                text: 'NEXT',
                color: Colors.yellow,
                onPressed: () {
                  // Implement NEXT logic
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
