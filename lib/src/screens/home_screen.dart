import 'package:flutter/material.dart';
import 'package:moviezone/src/Bloc/moviesprovider.dart';
import 'package:moviezone/src/models/item_model.dart';
import 'package:moviezone/src/screens/recent_movies.dart';
import 'package:moviezone/src/screens/top_rated_movies.dart';
import 'package:moviezone/src/widgets/sidebar.dart';

class HomeScreen extends StatefulWidget {
  createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesProvider.of(context);
      bloc.fetchMovies();
    });
    super.initState();
  }

  Widget build(context) {
    final bloc = MoviesProvider.of(context);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                Center(
                  child: Image.asset('assets/movie_appbar.png',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 30,
                        alignment: FractionalOffset.center,
                      ),
               ),
              Text('MovieFy', style: TextStyle(color: Colors.red[900]))
            ],
          )),
          iconTheme: new IconThemeData(color: Colors.red[900]),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.red[900]),
              onPressed: () {},
            ),
          ],
      ),
      body: StreamBuilder(
          stream: bloc.movies,
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Recent Movies',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        FlatButton(onPressed: () {}, child: Text('View All')),
                      ],
                    ),
                  ),

                  RecentMovie(),
                  
                  SizedBox(height: 17.0),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('TopRated Movies',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        FlatButton(onPressed: () {}, child: Text('View All')),
                      ],
                    ),
                  ),
                  
                  TopRatedMovies(),

                ],
              ),
            );
          }),
    );
  }
}
