import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../shared/theme/app_theme.dart';
import '../../news/page/news_page.dart';
import '../../animation/page/animation_page.dart';
import '../../map/page/map_page.dart';
import '../../qr/page/qr_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const NewsPage(),
    const AnimationPage(),
    const MapPage(),
    const QRPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Space 🌌✨'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthLogoutRequested());
              Navigator.of(context).pushReplacementNamed('/login');
            },
            tooltip: 'Logout 🚀',
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.spaceDark,
          boxShadow: [
            BoxShadow(
              color: AppTheme.spacePurple.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.spaceDark,
          selectedItemColor: AppTheme.spacePink,
          unselectedItemColor: AppTheme.spaceLight.withOpacity(0.6),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'News 📰',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.animation),
              label: 'Animations ✨',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map 🗺️',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'QR 💫',
            ),
          ],
        ),
      ),
    );
  }
}


