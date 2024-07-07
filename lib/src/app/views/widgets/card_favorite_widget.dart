import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardFavoriteWidget extends StatelessWidget {
  const CardFavoriteWidget({
    super.key,
    required this.url,
    required this.title,
    required this.data,
    required this.removeFavorite,
    required this.sharedImage,
  });

  final String url;
  final String title;
  final DateTime data;
  final void Function() removeFavorite;
  final void Function() sharedImage;
  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormat('dd/MM/yyyy');

    return Container(
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
            url,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
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
              onPressed: removeFavorite,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: sharedImage,
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
