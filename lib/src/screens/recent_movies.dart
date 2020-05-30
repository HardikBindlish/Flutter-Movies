import 'package:flutter/material.dart';
import 'package:moviezone/src/Bloc/moviesprovider.dart';
import 'package:moviezone/src/Bloc/moviestopprovider.dart';
import 'package:moviezone/src/models/item_model.dart';
import 'package:moviezone/src/models/item_model_top.dart';

import 'movies_detail.dart';

class RecentMovie extends StatefulWidget{
  createState(){
    return RecentMoviesState();
  }
}

class RecentMoviesState extends State<RecentMovie>{
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = MoviesTopProvider.of(context);
      bloc.fetchTrendingMovies();
    });
    super.initState();
  }

  Widget build(context){
    final bloc = MoviesTopProvider.of(context);
    return StreamBuilder(
            stream: bloc.topMovies,
            builder: (BuildContext context, AsyncSnapshot<List<TopMovie>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
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
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MoviesDetail(movie: snapshot.data[index].recent[index])
                                ));
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data[index].recent[index].image),
                                           fit: BoxFit.cover),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0,2.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                  ),
                                    
                                  SizedBox(
                                    height: 10.0,
                                  ),

                                  Text(
                                    snapshot.data[index].recent[index].title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                  ),
                                ],
                              ), 
                            )
                          );
                        },
                      ),
                    )
                  );
            }
      );
  }
}