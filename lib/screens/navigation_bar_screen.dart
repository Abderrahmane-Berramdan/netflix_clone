import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';
import 'package:netflix_clone/screens/home_screen.dart';
import 'package:netflix_clone/screens/hot_news_screen.dart';
import 'package:netflix_clone/screens/search_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int selctedIndex = 0;
  List<Widget> pages = [HomeScreen(), SearchScreen(), HotNewsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: black,
        onTap: (value) {
          setState(() {
            selctedIndex = value;
          });
        },
        currentIndex: selctedIndex,
        selectedItemColor: white,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 25),
        unselectedLabelStyle: TextStyle(fontSize: 13),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined),
            activeIcon: Icon(Icons.photo_library),
            label: "Hot News",
          ),
        ],
      ),
      body: pages[selctedIndex],
    );
  }
}
