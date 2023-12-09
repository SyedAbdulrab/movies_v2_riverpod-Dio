import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_v2/environment_config.dart';
import 'package:movies_v2/movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  final config = ref.read(environmentProvider);

  return MovieService(config, Dio());
});

class MovieService {
  MovieService(this._environmentConfig, this._dio);
  final EnvironmentConfig _environmentConfig;
  final Dio _dio;

  final String endpoint =
      'https://api.themoviedb.org/3/trending/movie/week?language=en-US';

  final apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMmU2ODExYWJhNzUwNTY1MWI2YzdlZWNhNDgzZGIyMiIsInN1YiI6IjY1NzQyZjQwNjZmMmQyMDExYmVjMWIxZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OORC5IfUdG7UdDpXy9d_WXg6xxpz7MnvIJa33-k3bUo";

  Future<List<Movie>> getMovies() async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $apiKey',
      'accept': 'application/json',
    };

    Response response =
        await _dio.get(endpoint, options: Options(headers: headers));
    print(response);
    //TODO: get a better understanding of the following two lines;
    final results = List<Map<String, dynamic>>.from(response.data['results']);
    List<Movie> movies =
        results.map((movie) => Movie.fromMap(movie)).toList(growable: false);

    return movies;
  }
}
