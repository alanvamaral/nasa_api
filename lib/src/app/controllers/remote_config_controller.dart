import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigController {
  late FirebaseRemoteConfig _firebaseRemoteConfig;

  RemoteConfigController._internal() {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
  }

  static final RemoteConfigController _singleton =
      RemoteConfigController._internal();

  factory RemoteConfigController() => _singleton;

  Future<void> initialize() async {
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
  }

  String getString(String key) {
    return _firebaseRemoteConfig.getString(key);
  }
}
