import 'package:flutter/material.dart';
import 'package:nasa_api/src/app/views/widgets/card_favorite_widget.dart';
import 'package:provider/provider.dart';

import '../../controllers/api_controller.dart';
import 'fav_image_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ApiController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: controller.favorite.isNotEmpty
            ? ListView.builder(
                itemCount: controller.favorite.length,
                itemBuilder: (context, index) {
                  final favorite = controller.favorite[index];
                  DateTime date = DateTime.parse(favorite.date!);

                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FavImagePage(
                            index: index,
                            shared: () {
                              controller.shareImage(favorite.url!);
                            },
                            title: favorite.title,
                            url: favorite.url!,
                          ),
                        ));
                      },
                      child: CardFavoriteWidget(
                        title: favorite.title!,
                        url: favorite.url!,
                        data: date,
                        removeFavorite: () {
                          controller.removeFavorite(favorite);
                        },
                        sharedImage: () {
                          controller.shareImage(favorite.url!);
                        },
                      ));
                },
              )
            : Center(
                child: Text(
                  'No favorites added',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
      ),
    );
  }
}
