import 'package:flutter/material.dart';
import 'package:moviezone/src/Bloc/moviesprovider.dart';
import 'package:moviezone/src/models/item_model.dart';
import 'package:moviezone/src/widgets/sidebar.dart';

class MoviesList extends StatefulWidget {
  createState() {
    return MoviesListState();
  }
}

class MoviesListState extends State<MoviesList> {
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

                  SizedBox(
                      height: 200,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 130,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data[index].image),
                                          fit: BoxFit.cover),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0,
                                              2.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                  ),
                                  
                                  SizedBox(
                                    height: 10.0,
                                  ),

                                  Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )),
                  
                  SizedBox(height: 17.0),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Trending Movies',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        FlatButton(onPressed: () {}, child: Text('View All')),
                      ],
                    ),
                  ),
                  
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      // height: 500,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Card(
                                  elevation: 5,
                                  child: Row(children: <Widget>[
                                    Container(
                                        height: 150,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.0),
                                              bottomLeft: Radius.circular(5.0)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  snapshot.data[index].image),
                                              fit: BoxFit.cover),
                                        )),
                                    Container(
                                      height: 150,
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(snapshot.data[index].title,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold)),

                                            SizedBox(
                                              height: 10.0,
                                            ),

                                            Container(
                                                width: 240,
                                                child: Text(
                                                  snapshot.data[index].story,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87),
                                                )
                                            ),

                                          ]
                                      ),
                                    ),
                                  ]
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  )),
                ],
              ),
            );
          }),
    );
  }
}
