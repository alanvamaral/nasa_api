import 'package:flutter/material.dart';
import 'package:nasa_api/src/app/views/pages/details_page.dart';
import 'package:nasa_api/src/app/views/widgets/card_widget.dart';
import 'package:provider/provider.dart';
import 'package:nasa_api/src/app/controllers/api_controller.dart';
import 'package:nasa_api/src/app/views/pages/favorite_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/card_skelton_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = context.read<ApiController>();
    if (controller.state == ApiState.idle) {
      controller.getApods();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ApiController>();

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 28,
          child: Image.asset('assets/images/nasa.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FavoritePage(),
              ));
            },
            icon: controller.favorite.isEmpty
                ? const Icon(Icons.favorite_border)
                : const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              controller.updateApods();
            },
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ApiController>(
          builder: (context, value, _) {
            if (controller.state == ApiState.loading) {
              return Center(
                  child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CardSkeltonWidget(
                    height: index.isEven ? 300 : 200,
                    width: index.isEven ? 300 : 200,
                  );
                },
                staggeredTileBuilder: (index) {
                  return const StaggeredTile.fit(1);
                },
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ));
            } else if (controller.state == ApiState.success) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: controller.apodFilter.length,
                itemBuilder: (context, index) {
                  final apodData = controller.apodFilter[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          index: index,
                          shared: () {
                            controller.shareImage(apodData.url!);
                          },
                          title: apodData.title,
                          url: apodData.url!,
                        ),
                      ));
                    },
                    child: CardWidget(
                      size: index.isEven ? 300 : 200,
                      url: apodData.url!,
                      title: apodData.title,
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return const StaggeredTile.fit(1);
                },
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              );
            } else {
              return const Center(
                child: Text('Falha ao carregar os dados.'),
              );
            }
          },
        ),
      ),
    );
  }
}
