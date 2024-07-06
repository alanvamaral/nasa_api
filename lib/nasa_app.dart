import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app/controllers/api_controller.dart';
import 'src/app/views/pages/home_page.dart';

class NasaApp extends StatelessWidget {
  const NasaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 45, 45, 45),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 26),
            backgroundColor: Color.fromARGB(255, 32, 32, 32),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
