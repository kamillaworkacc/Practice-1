import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showFirstImage = true;
  BoxFit _currentBoxFit = BoxFit.fill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab 4 - Flutter Widgets'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  _showFirstImage ? 'assets/image1.jpg' : 'assets/image2.jpg',
                  fit: _currentBoxFit,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50, color: Colors.grey[600]),
                            SizedBox(height: 10),
                            Text(
                              'Image not found\nCheck assets folder',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            Text(
              'Current Image: ${_showFirstImage ? "image1.jpg" : "image2.jpg"}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 8),
            
            Text(
              'Current BoxFit: ${_currentBoxFit.toString()}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            
            SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_currentBoxFit == BoxFit.fill) {
                    _currentBoxFit = BoxFit.contain;
                  } else if (_currentBoxFit == BoxFit.contain) {
                    _currentBoxFit = BoxFit.cover;
                  } else if (_currentBoxFit == BoxFit.cover) {
                    _currentBoxFit = BoxFit.fitWidth;
                  } else if (_currentBoxFit == BoxFit.fitWidth) {
                    _currentBoxFit = BoxFit.fitHeight;
                  } else if (_currentBoxFit == BoxFit.fitHeight) {
                    _currentBoxFit = BoxFit.none;
                  } else if (_currentBoxFit == BoxFit.none) {
                    _currentBoxFit = BoxFit.scaleDown;
                  } else {
                    _currentBoxFit = BoxFit.fill;
                  }
                });
              },
              child: Text('Next BoxFit'),
            ),
            
            SizedBox(height: 20),
            
            Container(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      _showFirstImage ? 'assets/image1.jpg' : 'assets/image2.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        'Welcome to Flutter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hello from SnackBar!'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'Show SnackBar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            Container(
              width: 200,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.green,
                ),
                child: Text(
                  'Go to Second Screen',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            Container(
              width: 200,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _showFirstImage = !_showFirstImage;
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.black),
                ),
                child: Text(
                  'Toggle Image',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to the Second Screen!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}