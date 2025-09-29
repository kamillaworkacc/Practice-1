import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: const Text('Pop'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.popAndPushNamed(context, '/third');
              } else {
                Navigator.pushNamed(context, '/third');
              }
            },
            child: const Text('PopAndPushNamed'),
          ),
        ],
      ),
    );
  }
}
