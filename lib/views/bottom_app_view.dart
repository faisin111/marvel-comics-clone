import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/views/character_view.dart';
import 'package:marvel_comics/views/comic_view.dart';
import 'package:marvel_comics/views/favourite_view.dart';

class BottomAppView extends StatefulWidget {
  const BottomAppView({super.key});

  @override
  State<BottomAppView> createState() => _BottomAppViewState();
}

class _BottomAppViewState extends State<BottomAppView> {
  List<Widget> pages = [CharacterView(), ComicView(), FavouriteView()];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppTheme.bgColor,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: h(0.2),

        titleSpacing: 16,

        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: w(0.02),
                vertical: h(0.015),
              ),
              color: AppTheme.primaryColor,
              child: Text(
                "MARVEL",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: w(0.04),
                  letterSpacing: .5,
                ),
              ),
            ),

            SizedBox(width: w(0.02)),

            Text(
              "CHARACTERS",
              style: TextStyle(
                color: Colors.grey,
                fontSize: w(0.04),
                fontWeight: FontWeight.w600,
                // letterSpacing: 1,
              ),
            ),
          ],
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.white.withOpacity(.08)),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.bgColor,
        unselectedItemColor: AppTheme.geyColor,
        selectedItemColor: AppTheme.primaryColor,

        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
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
      body: pages[selectedIndex],
    );
  }
}
