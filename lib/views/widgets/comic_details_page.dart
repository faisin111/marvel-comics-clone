import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/view_models/providers/comic_provider.dart';
import 'package:marvel_comics/views/widgets/rows.dart';

class ComicDetailsPage<T> extends ConsumerStatefulWidget {
  final int id;
  final T provider;
  final VoidCallback callFirst;
  final VoidCallback favCall;
  const ComicDetailsPage({
    super.key,
    required this.id,
    required this.provider,
    required this.callFirst,
    required this.favCall,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ComicDetailsPageState();
}

class _ComicDetailsPageState extends ConsumerState<ComicDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.callFirst();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double w(double value) => size.width * value;

    double h(double value) => size.height * value;
    final comic = ref.watch(widget.provider);
    return comic.loading
        ? Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
              strokeWidth: 1.5,
            ),
          )
        : comic.detailed == null
        ? Scaffold(
            backgroundColor: AppTheme.bgColor,
            body: Center(
              child: Text("No Data", style: TextStyle(color: Colors.white)),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xff0F1014),

            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h(.45),
                    width: double.infinity,
                    child: Stack(
                      children: [
                        /// Background Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(w(.08)),
                            bottomRight: Radius.circular(w(.08)),
                          ),
                          child: comic.detailed!.image.isEmpty
                              ? Container(
                                  color: const Color(0xff202329),
                                  child: Center(
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.white38,
                                      size: w(.15),
                                    ),
                                  ),
                                )
                              : Image.network(
                                  comic.detailed!.image,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),

                        /// Gradient
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(w(.08)),
                              bottomRight: Radius.circular(w(.08)),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(.15),
                                Colors.transparent,
                                Colors.black.withOpacity(.85),
                              ],
                            ),
                          ),
                        ),

                        /// Back Button
                        Positioned(
                          top: h(.06),
                          left: w(.05),
                          child: CircleAvatar(
                            radius: w(.06),
                            backgroundColor: Colors.black45,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: w(.05),
                              ),
                            ),
                          ),
                        ),

                        /// Favourite Button
                        Positioned(
                          top: h(.06),
                          right: w(.05),
                          child: CircleAvatar(
                            radius: w(.06),
                            backgroundColor: Colors.black45,
                            child: IconButton(
                              onPressed: () {
                                widget.favCall();
                              },
                              icon: Icon(
                                comic.detailed!.isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                                color: comic.detailed!.isFav
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),

                        /// Character Name
                        Positioned(
                          left: w(.05),
                          right: w(.05),
                          bottom: h(.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comic.detailed!.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: w(.075),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: h(.005)),

                              Text(
                                comic.detailed!.name,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: w(.04),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ABOUT",
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: w(.04),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: h(.015)),

                        Text(
                          comic.detailed?.description ??
                              "No description available.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: w(.037),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  infoCard(
                    Icons.menu_book,
                    "Issue Number",
                    comic.detailed!.issueNumber,
                  ),

                  infoCard(
                    Icons.collections_bookmark,
                    "Volume",
                    comic.detailed!.volumeName,
                  ),

                  infoCard(
                    Icons.calendar_today,
                    "Cover Date",
                    comic.detailed!.coverDate,
                  ),

                  infoCard(
                    Icons.store,
                    "Store Date",
                    comic.detailed!.storeDate,
                  ),
                ],
              ),
            ),
          );
  }
}
