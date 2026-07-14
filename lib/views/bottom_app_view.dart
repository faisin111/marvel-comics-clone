import 'package:flutter/material.dart';

class BottomAppView extends StatefulWidget {
  const BottomAppView({super.key});

  @override
  State<BottomAppView> createState() => _BottomAppViewState();
}

class _BottomAppViewState extends State<BottomAppView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "CHARACTERS",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "COMICS"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "FAVOURITES",
          ),
        ],
      ),
    );
  }
}
