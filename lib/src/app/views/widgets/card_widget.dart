import 'package:flutter/material.dart';

import 'card_skelton_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key, required this.size, required this.url, this.title});

  final double size;
  final String url;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.network(
            url,
            fit: BoxFit.cover,
            height: size,
            width: size,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                    child: CardSkeltonWidget(
                  height: size,
                  width: size,
                ));
              }
            },
          ),
          Positioned.fill(
            child: Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
