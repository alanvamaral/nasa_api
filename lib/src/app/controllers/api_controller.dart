import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_api/src/app/controllers/remote_config_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../models/apod_model.dart';

enum ApiState { idle, success, loading, error }

class ApiController extends ChangeNotifier {
  final List<ApodModel> favorite = [];
  List<ApodModel> apod = [];
  List<ApodModel> apodFilter = [];
  var state = ApiState.idle;

  void removeFavorite(ApodModel apodData) {
    favorite.remove(apodData);
    notifyListeners();
  }

  Future<void> addFavorite(ApodModel apodData) async {
    favorite.add(apodData);
    notifyListeners();
  }

  Future<void> updateApods() async {
    state = ApiState.loading;
    notifyListeners();
    await getApods();
  }

  Future<void> getApods() async {
    try {
      state = ApiState.loading;
      apod.clear();

      String apiKey = RemoteConfigController().getString('apikey');
      var response = await http.get(
        Uri.https(
          'api.nasa.gov',
          '/planetary/apod',
          {'api_key': apiKey, 'count': '30'},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var eachApod in jsonData) {
          final apodToday = ApodModel(
            copyright: eachApod['copyright'],
            date: eachApod['date'],
            explanation: eachApod['explanation'],
            hdurl: eachApod['hdurl'],
            mediaType: eachApod['media_type'],
            serviceVersion: eachApod['service_version'],
            title: eachApod['title'],
            url: eachApod['url'],
          );

          apod.add(apodToday);
          apodFilter =
              apod.where((apod) => apod.url!.endsWith('.jpg')).toList();
          state = ApiState.success;
        }
      } else if (response.statusCode == 429) {
        debugPrint('Erro: Muitas solicitações. Tente novamente mais tarde.');
        state = ApiState.error;
      } else {
        state = ApiState.error;
        debugPrint('Erro ao carregar APOD: Status ${response.statusCode}');
      }
    } catch (e) {
      state = ApiState.error;
      debugPrint('Erro ao carregar APOD: $e');
    }
    notifyListeners();
  }

  Future<void> getTemporaryDirectoryExample() async {
    try {
      final tempDir = await getTemporaryDirectory();
      debugPrint('Temporary directory path: ${tempDir.path}');
    } catch (e) {
      debugPrint('Error getting temporary directory: $e');
    }
  }

  Future<void> shareImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      final bytes = response.bodyBytes;

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/image.jpg');
      await tempFile.writeAsBytes(bytes);

      await Share.shareFiles([tempFile.path], text: 'Check out this image!');
    } catch (e) {
      debugPrint('Error sharing image: $e');
    }
  }
}
