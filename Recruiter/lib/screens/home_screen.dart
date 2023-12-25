import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/pages/add.dart';
import 'package:recruiter/pages/list.dart';
import 'package:recruiter/pages/profile.dart';
import 'package:recruiter/pages/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "Favorite",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart,
        color: Color.fromARGB(205, 22, 68, 87),
      ),
      label: "My Cart",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        children: const [
          List(),
          Search(),
          Add(),
          Profile(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: const [
          Icon(Icons.list),
          Icon(Icons.search),
          Icon(Icons.add),
          Icon(Icons.person_pin, size: 30),
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease); //Handle button tap
        },
      ),
    );
  }
}
