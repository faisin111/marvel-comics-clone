import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.image,
    required this.name,
    required this.comics,
    this.isFavourite = false,
    this.onFavourite,
    this.onTap,
  });

  final String image;
  final String name;
  final int comics;
  final bool isFavourite;
  final VoidCallback? onFavourite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff18181B),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(.08),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Gradient
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(.65),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Favourite Button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: onFavourite,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 18,
                          color: isFavourite
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "$comics Comics",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ComicCard extends StatelessWidget {
  const ComicCard({
    super.key,
    required this.image,
    required this.title,
   
    required this.index,
    this.isFavorite = false,
    this.onFavorite,
    this.onTap,
  });

  final String image;
  final String title;
 
  final int index;
  final bool isFavorite;
  final VoidCallback? onFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff18181B),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(.06),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE
            Expanded(
              child: Stack(
                children: [

                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// gradient
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(.45),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Issue Number
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "#$index",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),

                  /// Favorite
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: onFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.45),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      height: 1.2,
                    ),
                  ),

                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}