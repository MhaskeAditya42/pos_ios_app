import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MerchantCodeScreen extends StatefulWidget {
  const MerchantCodeScreen({super.key});

  @override
  _MerchantCodeScreenState createState() => _MerchantCodeScreenState();
}

class _MerchantCodeScreenState extends State<MerchantCodeScreen> {
  final TextEditingController merchantCodeController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';
  bool showWebView = false;
  String loginUrl = '';

  // Shared Preferences for saving merchant code
  Future<void> saveMerchantCode(String merchantCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('MERCHANT_CODE', merchantCode);
  }

  // Function to verify the merchant code
  Future<void> verifyMerchantCode(String merchantCode) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final url = 'https://api.menulive.in/api/merchant/verify/$merchantCode';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the merchant code is valid (use the actual key returned by your API)
        if (data[0]["merchantCode"].toString() == merchantCode) {
          // Save merchant code to local storage
          await saveMerchantCode(merchantCode);

          // Set the login URL and show WebView
          setState(() {
            loginUrl = 'https://pos.menulive.in/?merchantCode=$merchantCode';
            showWebView = true;
          });
        } else {
          setState(() {
            errorMessage = 'Merchant Not Found!';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error verifying the merchant code. Try again later.';
        });
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        errorMessage = 'Failed to connect to the server: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: showWebView
          ? WebViewContainer(
              url: loginUrl) // Load the WebView if the URL is set
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('../assests/menulive_icon.png', height: 100),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome!',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please enter the merchant code to proceed',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  if (errorMessage.isNotEmpty) ...[
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: merchantCodeController,
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
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            final merchantCode =
                                merchantCodeController.text.trim();
                            if (merchantCode.isNotEmpty) {
                              verifyMerchantCode(merchantCode);
                            } else {
                              setState(() {
                                errorMessage =
                                    'Please enter a valid merchant code.';
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            textStyle: const TextStyle(color: Colors.black),
                          ),
                          child: const Text("LET'S GO"),
                        ),
                ],
              ),
            ),
    );
  }
}

// WebView widget to display the login page with the merchant code URL
class WebViewContainer extends StatefulWidget {
  final String url;

  const WebViewContainer({required this.url, super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Initialize the WebView controller and load the URL
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
      ..loadRequest(
          Uri.parse(widget.url)); // Load initial URL from the parent widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchant Login'),
      ),
      body: WebViewWidget(
          controller: controller), // Display WebView with the controller
    );
  }
}
