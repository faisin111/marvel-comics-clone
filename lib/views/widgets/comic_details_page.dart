
import 'package:flutter/material.dart';

class ComicDetailsPage extends StatelessWidget {
  const ComicDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1014),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.people_outline), label: "Characters"),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: "Comics"),
          NavigationDestination(icon: Icon(Icons.favorite_outline), label: "Favorites"),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xff111216),
            pinned: true,
            expandedHeight: 340,
            automaticallyImplyLeading: false,
            title: const Row(
              children: [
                Icon(Icons.arrow_back,color: Colors.red,size:18),
                SizedBox(width: 12),
                DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xffED1D24)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("MARVEL",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text("THE AVENGERS #1",
                    style: TextStyle(color: Colors.grey,fontSize: 13))
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1612036782180-6f0822045d74?q=80&w=1200",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xff0F1014)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: Icon(Icons.arrow_back,color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: Icon(Icons.favorite_border,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "THE AVENGERS #1",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "\$3.99",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height:18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _Chip("Avengers"),
                      _Chip("32 pages"),
                      _Chip("2023"),
                    ],
                  ),
                  const SizedBox(height:30),
                  _SectionTitle("SYNOPSIS"),
                  const SizedBox(height:10),
                  const Text(
                    "The original Avengers assemble for the first time to battle a cosmic threat that no single hero could withstand alone.",
                    style: TextStyle(color: Colors.white70,height: 1.6),
                  ),
                  const SizedBox(height:28),
                  _SectionTitle("CHARACTERS"),
                  const SizedBox(height:12),
                  Wrap(
                    spacing:8,
                    runSpacing:8,
                    children: const [
                      _Chip("Iron Man"),
                      _Chip("Thor"),
                      _Chip("Hulk"),
                      _Chip("Captain America"),
                    ],
                  ),
                  const SizedBox(height:40),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget{
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context){
    return Text(
      title,
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _Chip extends StatelessWidget{
  final String text;
  const _Chip(this.text);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:12,vertical:8),
      decoration: BoxDecoration(
        color: const Color(0xff1D2027),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
    );
  }
}
