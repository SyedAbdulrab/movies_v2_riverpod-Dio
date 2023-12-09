import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_v2/movie.dart';
import 'package:movies_v2/movie_services.dart';
import 'dart:ui';



final popularMoviesProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.keepAlive();

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovies();
  return movies;
});

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final _moviesData = ref.watch(popularMoviesProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:const Text("Popular Movies"
        ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
        elevation: 0,
        centerTitle: true,
      ),
      body: _moviesData.when(
          data: (movies) {
            return RefreshIndicator(onRefresh: () async {
               ref.refresh(popularMoviesProvider);
            },
                child:  GridView.extent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
                children: [
                  ...movies.map((movie) =>InkWell(child:  _MovieBox(movie: movie),onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Scaffold(backgroundColor: Colors.black, appBar:AppBar(backgroundColor: Colors.black, title: Text(movie.title,style: TextStyle(color: Colors.red),),),body: Padding(padding: EdgeInsets.symmetric(horizontal: 40,vertical: 30),child: SingleChildScrollView(child: Column(
                      children: [
                        _MovieBox(movie: movie),
                        SizedBox(height: 20,),
                        Text(movie.overview,style:const TextStyle(color: Colors.white54),)
                      ],
                    )),),),),);
                  },)).toList(),
                ]), );
          },
          error: (err, s) {
            return Text(err.toString());
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}


class _MovieBox extends StatelessWidget {
  final Movie movie;

  const _MovieBox({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          movie.fullImageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _FrontBanner(text: movie.title),
        ),
      ],
    );
  }
}

class _FrontBanner extends StatelessWidget {
  const _FrontBanner({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.grey.shade200.withOpacity(0.5),
          height: 60,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}