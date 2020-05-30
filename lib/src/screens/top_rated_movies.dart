import 'package:flutter/material.dart';
import 'package:moviezone/src/Bloc/moviestopprovider.dart';
import 'package:moviezone/src/models/item_model_top.dart';
import 'movies_detail.dart';

class TopRatedMovies extends StatefulWidget{
  createState(){
    return TopRatedMoviesState();
  }
}

class TopRatedMoviesState extends State<TopRatedMovies>{

@override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesTopProvider.of(context);
      bloc.fetchTrendingMovies();
    });
    super.initState();
  }

  Widget build(context) {
    final bloc = MoviesTopProvider.of(context);
    return StreamBuilder(
        stream: bloc.topMovies,
        builder:
            (BuildContext context, AsyncSnapshot<List<TopMovie>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Flexible(
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
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MoviesDetail(movie: snapshot.data[index].topRated[index])));
                      },
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
                                            snapshot.data[index].topRated[index].image),
                                        fit: BoxFit.cover),
                                  )),
                              Container(
                                height: 150,
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(snapshot.data[index].topRated[index].title,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                          width: 240,
                                          child: Text(
                                            snapshot.data[index].topRated[index].story,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black87),
                                          )),
                                    ]),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ));
                  },
                ),
              ));
        });
  }
}
