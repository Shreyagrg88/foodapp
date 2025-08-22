import 'package:flutter/material.dart';
import 'package:foodapp/presentation/screen/homepage.dart';
import 'search.dart';
import 'notification.dart';
import 'profile.dart';
// import 'add_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    Container(), // placeholder for center FAB
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        onPressed: () {
          setState(() {
            _currentIndex = 2; // center "Add" screen
          });
        },
        child: const Icon(Icons.add, color: Colors.teal, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.orange,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color: _currentIndex == 0 ? Colors.white : Colors.black54),
                onPressed: () => setState(() => _currentIndex = 0),
              ),
              IconButton(
                icon: Icon(Icons.search,
                    color: _currentIndex == 1 ? Colors.white : Colors.black54),
                onPressed: () => setState(() => _currentIndex = 1),
              ),
              const SizedBox(width: 40), // space for FAB
              IconButton(
                icon: Icon(Icons.notifications,
                    color: _currentIndex == 3 ? Colors.white : Colors.black54),
                onPressed: () => setState(() => _currentIndex = 3),
              ),
              IconButton(
                icon: Icon(Icons.person,
                    color: _currentIndex == 4 ? Colors.white : Colors.black54),
                onPressed: () => setState(() => _currentIndex = 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
