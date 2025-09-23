import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 - Flutter UI',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showSnack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _showToast() {
    Fluttertoast.showToast(msg: "Hello, Flutter!", gravity: ToastGravity.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lab 5 - Flutter UI'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List', icon: Icon(Icons.list)),
              Tab(text: 'Images', icon: Icon(Icons.grid_on)),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Show Toast',
              onPressed: _showToast,
              icon: const Icon(Icons.message),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 't2') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ListTenPage()));
                } else if (value == 't3') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const GridColorsPage()));
                } else if (value == 't4') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CardsPage()));
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 't2', child: Text('Task 2: ListView (10 items)')),
                PopupMenuItem(value: 't3', child: Text('Task 3: Grid (colors)')),
                PopupMenuItem(value: 't4', child: Text('Task 4: Cards')),
              ],
            ),
          ],
        ),
        drawer: Builder(
          builder: (context) => Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.indigo),
                  child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnack(context, 'Home selected');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnack(context, 'Profile selected');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnack(context, 'Settings selected');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnack(context, 'Logout selected');
                  },
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Task1ListTab(),
            Task1ImagesTab(),
          ],
        ),
      ),
    );
  }
}

class Task1ListTab extends StatelessWidget {
  const Task1ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(5, (i) => 'List item ${i + 1}');
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.label),
          title: Text(items[index]),
        );
      },
    );
  }
}

class Task1ImagesTab extends StatelessWidget {
  const Task1ImagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/img1.jpg',
      'assets/img2.jpg',
      'assets/img3.jpg',
      'assets/img4.jpg',
      'assets/img5.jpg',
      'assets/img6.jpg',
    ];
    return GridView.count(
      crossAxisCount: 2,
      children: images.map((path) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: Text(path, textAlign: TextAlign.center),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class ListTenPage extends StatelessWidget {
  const ListTenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(10, (i) => i + 1);
    return Scaffold(
      appBar: AppBar(title: const Text('Task 2 - ListView (10 items)')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: CircleAvatar(child: Text('${items[i]}')),
            title: Text('Item ${items[i]}'),
            subtitle: Text('Subtitle ${items[i]}'),
          );
        },
      ),
    );
  }
}

class GridColorsPage extends StatelessWidget {
  const GridColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = <Color>[
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Task 3 - Grid (colors)')),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(12),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(colors.length, (i) {
          return Container(
            color: colors[i],
            child: Center(
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {'title': 'Sunset', 'desc': 'A calm sunset over the hills.', 'img': 'assets/card1.jpg'},
      {'title': 'Forest', 'desc': 'Green trees and fresh air.', 'img': 'assets/card2.jpg'},
      {'title': 'City', 'desc': 'Lights and buildings at night.', 'img': 'assets/card3.jpg'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Task 4 - Cards')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: data.length,
        itemBuilder: (context, i) {
          final item = data[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  item['img']!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: Text(item['img']!),
                  ),
                ),
                ListTile(
                  title: Text(item['title']!),
                  subtitle: Text(item['desc']!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}