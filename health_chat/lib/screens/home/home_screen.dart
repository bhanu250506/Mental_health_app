import 'package:flutter/material.dart';
import 'package:health_chat/screens/chat/chat_screen.dart';

import '../more/exercises_screen.dart';
import '../more/mood_tracker.dart';
import '../more/quotes_screen.dart';
import '../more/setting_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ChatScreen(),
    MoodTrackerScreen(),
    ExercisesScreen(),
    QuotesScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.sentiment_satisfied_outlined), activeIcon: Icon(Icons.sentiment_satisfied), label: 'Moods'),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement_outlined), activeIcon: Icon(Icons.self_improvement), label: 'Exercises'),
          BottomNavigationBarItem(icon: Icon(Icons.format_quote_outlined), activeIcon: Icon(Icons.format_quote), label: 'Quotes'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}

