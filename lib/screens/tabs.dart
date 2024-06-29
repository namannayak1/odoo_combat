import 'package:diet_recomm/screens/home_screen.dart';
import 'package:diet_recomm/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    
    List<Widget> screens  =[const HomeScreen(),const ProfilePersonScreen()];

    
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
        

      ]),
    );
  }
}