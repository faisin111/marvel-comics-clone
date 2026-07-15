import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/view_models/providers/character_provider.dart';
import 'package:marvel_comics/views/widgets/cards.dart';
import 'package:marvel_comics/views/widgets/character_details_screen.dart';
import 'package:marvel_comics/views/widgets/serach_bar_field.dart';
import 'package:marvel_comics/widgets/errors.dart';

class CharacterView extends ConsumerStatefulWidget {
  const CharacterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterViewState();
}

class _CharacterViewState extends ConsumerState<CharacterView> {
  final TextEditingController controllerSearch = TextEditingController();
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(characterProvider.notifier).getAllchar();
    });
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        ref.read(characterProvider.notifier).loadMorechar();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    controllerSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    final char = ref.watch(characterProvider);
   
    return ListView(
      controller: controller,
      padding: EdgeInsets.all(w(0.04)),
      children: [
        SerachBarField(
          controller: controllerSearch,
          onChanged: (value) {
            if (value.isEmpty) {
              ref.read(characterProvider.notifier).getAllchar();
            } else {
              ref.read(characterProvider.notifier).searchCharacter(value);
            }
          },
        ),
        SizedBox(height: h(0.04)),

        char.loading
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
            : char.succes
            ? GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemCount: char.characters.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: .68,
                ),
                itemBuilder: (_, index) {
                  if (char.characters.length == index) {
                    Center(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                          strokeWidth: 1.5,
                        ),
                      ),
                    );
                  }
                  final item = char.characters[index];
                  return CharacterCard(
                    image: item.image,
                    name: item.name,
                    comics: item.issueAppearances,
                    isFavourite: item.isFav,

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedCharacterView(
                            id: item.id,
                            provider: characterProvider,
                            favCall: () async {
                              if (item.isFav) {
                                await ref
                                    .read(characterProvider.notifier)
                                    .removeFav(item.id, detailed: true);

                                return;
                              }
                              await ref
                                  .read(characterProvider.notifier)
                                  .addFav(item, detailed: true);
                            },
                            firstCall: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ref
                                    .read(characterProvider.notifier)
                                    .detailedCharacter(item.id);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    onFavourite: () async {
                      if (item.isFav) {
                        await ref
                            .read(characterProvider.notifier)
                            .removeFav(item.id);

                        return;
                      }
                      await ref.read(characterProvider.notifier).addFav(item);
                    },
                  );
                },
              )
            : Column(
                children: [
                  SizedBox(height: h(0.4)),
                  Builder(
                    builder: (context) {
                      switch (char.type?.type) {
                        case AuthException:
                          return ErrorViews.unauthorized(
                            onRetry: () {
                              ref.read(characterProvider.notifier).getAllchar();
                            },
                          );
                        case NoInternetException:
                          return ErrorViews.noInternet(
                            onRetry: () {
                              ref.read(characterProvider.notifier).getAllchar();
                            },
                          );
                        case NotfoundException:
                          return ErrorViews.notFound();
                        case TimeoutException:
                          return ErrorViews.timeout(
                            onRetry: () {
                              ref.read(characterProvider.notifier).getAllchar();
                            },
                          );
                        case ServerException:
                          return ErrorViews.serverError(
                            onRetry: () {
                              ref.read(characterProvider.notifier).getAllchar();
                            },
                          );
                        default:
                          return ErrorViews.unknown(
                            onRetry: () {
                              ref.read(characterProvider.notifier).getAllchar();
                            },
                          );
                      }
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
