import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/api_controller.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    this.title,
    required this.url,
    required this.shared,
    required this.index,
  });

  final String? title;
  final String url;
  final void Function() shared;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ApiController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title ?? '',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: shared,
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (controller.favorite
                        .contains(controller.apodFilter[index])) {
                      controller.removeFavorite(controller.apodFilter[index]);
                    } else {
                      controller.addFavorite(controller.apodFilter[index]);
                    }
                  },
                  icon: Icon(
                    controller.favorite.contains(controller.apodFilter[index])
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
