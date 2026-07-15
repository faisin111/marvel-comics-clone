import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/view_models/providers/comic_provider.dart';
import 'package:marvel_comics/views/widgets/cards.dart';
import 'package:marvel_comics/views/widgets/comic_details_page.dart';
import 'package:marvel_comics/views/widgets/serach_bar_field.dart';
import 'package:marvel_comics/widgets/errors.dart';

class ComicView extends ConsumerStatefulWidget {
  const ComicView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComicViewState();
}

class _ComicViewState extends ConsumerState<ComicView> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(comicProvider.notifier).getAllchar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final comic = ref.watch(comicProvider);
    final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    return ListView(
      padding: EdgeInsets.all(w(0.04)),
      children: [
        SerachBarField(
          controller: controller,
          onChanged: (value) {
            if (value.isEmpty) {
              ref.read(comicProvider.notifier).getAllchar();
            } else {
              ref.read(comicProvider.notifier).searchCharacter(value);
            }
          },
        ),
        SizedBox(height: h(0.04)),

        comic.loading
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
            : comic.succes
            ? GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemCount: comic.comics.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: .68,
                ),
                itemBuilder: (_, index) {
                  final item = comic.comics[index];

                  return ComicCard(
                    image: item.image,
                    title: item.name,
                    isFavorite: item.isFav,
                    index: index,
                    onFavorite: () async {
                      if (item.isFav) {
                        await ref
                            .read(comicProvider.notifier)
                            .removeFav(item.id);

                        return;
                      }
                      await ref.read(comicProvider.notifier).addFav(item);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComicDetailsPage(id: item.id),
                        ),
                      );
                    },
                  );
                },
              )
            : Column(
                children: [
                  SizedBox(height: h(0.4)),
                  Builder(
                    builder: (context) {
                      switch (comic.type?.type) {
                        case AuthException:
                          return ErrorViews.unauthorized(
                            onRetry: () {
                              ref.read(comicProvider.notifier).getAllchar();
                            },
                          );
                        case NoInternetException:
                          return ErrorViews.noInternet(
                            onRetry: () {
                              ref.read(comicProvider.notifier).getAllchar();
                            },
                          );
                        case NotfoundException:
                          return ErrorViews.notFound();
                        case TimeoutException:
                          return ErrorViews.timeout(
                            onRetry: () {
                              ref.read(comicProvider.notifier).getAllchar();
                            },
                          );
                        case ServerException:
                          return ErrorViews.serverError(
                            onRetry: () {
                              ref.read(comicProvider.notifier).getAllchar();
                            },
                          );
                        default:
                          return ErrorViews.unknown(
                            onRetry: () {
                              ref.read(comicProvider.notifier).getAllchar();
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
