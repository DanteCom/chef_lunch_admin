import 'package:flutter/material.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          const SafeArea(
            child: Text(
              'Connection error',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          const Spacer(),
          Image.asset('assets/images/wifi.png'),
          const Text('No internet connection'),
          const SizedBox(height: 35),
          const Text(
            'Failed to connect to chef lanch. Please check your\n your device\'s network connection',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
