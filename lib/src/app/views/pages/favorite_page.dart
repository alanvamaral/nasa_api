import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
                  final formatDate = DateFormat('dd/MM/yyyy');
                  DateTime data = DateTime.parse(favorite.date!);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FavImagePage(
                          index: index,
                          shared: () {
                            controller.shareImage(favorite.url!);
                          },
                          title: favorite.title ?? '',
                          url: favorite.url!,
                        ),
                      ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 69, 69, 69),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            favorite.url!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          favorite.title ?? 'Untitled',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          'Date: ${formatDate.format(data)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.removeFavorite(favorite);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.shareImage(favorite.url!);
                              },
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
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
