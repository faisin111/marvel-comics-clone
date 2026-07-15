import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/view_models/providers/character_provider.dart';
import 'package:marvel_comics/views/widgets/rows.dart';

class DetailedCharacterView<T> extends ConsumerStatefulWidget {
  final int id;
  final T provider;
  final VoidCallback firstCall;
  final VoidCallback favCall;
  const DetailedCharacterView({
    super.key,
    required this.id,
    required this.provider,
    required this.firstCall,
    required this.favCall,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailedCharacterViewState();
}

class _DetailedCharacterViewState extends ConsumerState<DetailedCharacterView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.firstCall();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double w(double w) => size.width * w;
    double h(double h) => size.width * h;
    final data = ref.watch(widget.provider);
    return data.loading
        ? Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
              strokeWidth: 1.5,
            ),
          )
        : data.detailed == null
        ? Scaffold(
            backgroundColor: AppTheme.bgColor,
            body: Center(
              child: Text("No Data", style: TextStyle(color: Colors.white)),
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
                      onPressed: () {
                        widget.favCall();
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: data.detailed!.image,
                          fit: BoxFit.cover,
                          placeholder: (_, __) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (_, __, ___) => Container(
                            color: Colors.grey.shade900,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.white38,
                              size: 60,
                            ),
                          ),
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
