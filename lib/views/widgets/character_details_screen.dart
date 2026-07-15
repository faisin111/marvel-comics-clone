import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/view_models/providers/character_provider.dart';
import 'package:marvel_comics/views/widgets/rows.dart';

class detailedCharacterView extends ConsumerStatefulWidget {
  final int id;
  const detailedCharacterView({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _detailedCharacterViewState();
}

class _detailedCharacterViewState extends ConsumerState<detailedCharacterView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(characterProvider.notifier).detailedCharacter(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    final data = ref.watch(characterProvider);
    return data.loading
        ? Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
              strokeWidth: 1.5,
            ),
          )
        : Scaffold(
            backgroundColor: AppTheme.bgColor,

            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: h(.42),
                  pinned: true,
                  backgroundColor: AppTheme.bgColor,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, size: w(.06)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        data.detailed!.isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18,
                        color: data.detailed!.isFav ? Colors.red : Colors.white,
                      ),
                      onPressed: () async {
                        if (data.isFav) {
                          await ref
                              .read(characterProvider.notifier)
                              .removeFav(widget.id, detailed: true);

                          return;
                        }
                        await ref
                            .read(characterProvider.notifier)
                            .addFav(data.detailed!, detailed: true);
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: data.detailed?.detailedImg ?? "",
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xff0F1115)],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.detailed?.name ?? "",
                          style: TextStyle(
                            fontSize: w(.08),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          "ABOUT",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          data.detailed?.deck ?? "No Description",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: w(.036),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(w(.04)),
                          decoration: BoxDecoration(
                            color: const Color(0xff18181B),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              infoRow(
                                "Real Name",
                                data.detailed?.realName ?? "-",
                              ),
                              infoRow(
                                "Publisher",
                                data.detailed?.publisher ?? "-",
                              ),
                              infoRow("Origin", data.detailed?.origin ?? "-"),
                              infoRow(
                                "Comic Appearances",
                                "${data.detailed?.issueAppearances ?? 0}",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
