// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Movie {
  String title;
  String posterPath;
  String overview;

  Movie({
    
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  String get fullImageUrl => "https://image.tmdb.org/t/p/w200$posterPath";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title:map['title'] as String,
      posterPath: map['poster_path'] as String,
      overview: map['overview'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
