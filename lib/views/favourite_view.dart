import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/view_models/controllers/favourite_controller.dart';
import 'package:marvel_comics/view_models/providers/character_provider.dart';
import 'package:marvel_comics/view_models/providers/favourite_provider.dart';
import 'package:marvel_comics/view_models/state/favourite_state.dart';
import 'package:marvel_comics/views/widgets/cards.dart';
import 'package:marvel_comics/views/widgets/character_details_screen.dart';
import 'package:marvel_comics/views/widgets/comic_details_page.dart';
import 'package:marvel_comics/views/widgets/fav_filter.dart';
import 'package:marvel_comics/widgets/errors.dart';

class FavouriteView extends ConsumerStatefulWidget {
  const FavouriteView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends ConsumerState<FavouriteView> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favouriteProvider.notifier).getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    final fav = ref.watch(favouriteProvider);
    return ListView(
      padding: EdgeInsets.all(w(0.04)),
      children: [
        fav.comics.isNotEmpty || fav.characters.isNotEmpty
            ? const FavFilter()
            : const SizedBox(),
        SizedBox(height: h(0.04)),

        fav.loading
            ? Column(
                children: [
                  SizedBox(height: h(0.45)),
                  Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                      strokeWidth: 1.5,
                    ),
                  ),
                  SizedBox(height: h(0.03)),
                  Text(
                    "Loading...",
                    style: GoogleFonts.poppins(
                      fontSize: w(0.04),
                      color: AppTheme.geyColor,
                    ),
                  ),
                ],
              )
            : fav.succes && fav.all.isNotEmpty
            ? GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemCount: fav.all.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: .68,
                ),
                itemBuilder: (_, index) {
                  final item = fav.all[index];
                  if (item is CharacterModel) {
                    return CharacterCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedCharacterView(
                              favCall: () async {
                                
                                if (item.isFav) {
                                  await ref
                                      .read(favouriteProvider.notifier)
                                      .removeFav(item.id, detailed: true);

                                  return;
                                }
                                await ref
                                    .read(favouriteProvider.notifier)
                                    .addFav(item, char: true);
                              },
                              id: item.id,
                              provider: favouriteProvider,
                              firstCall: () {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  ref
                                      .read(favouriteProvider.notifier)
                                      .getDetailed(item.id);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      onFavourite: () async {
                        await ref
                            .read(favouriteProvider.notifier)
                            .removeFav(item.id, isChar: true);
                      },
                      image: item.image,
                      name: item.name,
                      comics: item.issueAppearances,
                      viewFav: true,
                    );
                  }
                  return ComicCard(
                    image: item.image,
                    title: item.name,
                    isFavorite: item.isFav,
                    index: index,
                    viewFav: true,
                    onFavorite: () async {
                      await ref
                          .read(favouriteProvider.notifier)
                          .removeFav(item.id);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComicDetailsPage(
                            id: item.id,
                            provider: favouriteProvider,
                            favCall: () async {
                              if (item.isFav) {
                                await ref
                                    .read(favouriteProvider.notifier)
                                    .removeFav(item.id);

                                return;
                              }
                              await ref
                                  .read(favouriteProvider.notifier)
                                  .addFav(item);
                            },
                            callFirst: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ref
                                    .read(favouriteProvider.notifier)
                                    .getDetailed(item.id);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : fav.all.isEmpty
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w(.08)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: w(.22),
                        height: w(.22),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.red,
                          size: w(.10),
                        ),
                      ),

                      SizedBox(height: h(.03)),

                      Text(
                        "No Favourites Yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w(.06),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: h(.01)),

                      Text(
                        "Tap the heart on any character or comic to save it here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: w(.038),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  SizedBox(height: h(0.4)),
                  Builder(
                    builder: (context) {
                      return ErrorViews.unknown(
                        onRetry: () {
                          ref.read(favouriteProvider.notifier).getAll();
                        },
                      );
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
