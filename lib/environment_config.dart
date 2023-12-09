import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentConfig{
  // we add  the api key by running 'flutter urn --dart-define=movieApiKey=MYKEY'
  final movieApiKey = "eyJhbGciOiJIUzI1NiJ9.02e6811aba7505651b6c7eeca483db22.OORC5IfUdG7UdDpXy9d_WXg6xxpz7MnvIJa33-k3bUo" ;//const String.fromEnvironment("movieApiKey");

}


final environmentProvider = Provider<EnvironmentConfig>((ref){
  return EnvironmentConfig();
});

