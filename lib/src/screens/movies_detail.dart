import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moviezone/src/models/item_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';


class MoviesDetail extends StatelessWidget{
  final Movie movie;

  MoviesDetail({@required this.movie});

  Widget build(context){
   
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff4f4f4),
        iconTheme: IconThemeData(
          color: Colors.red[900], 
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 400,
                  width:280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(movie.image)
                    )
                  ),
                )
              ),
            ),

            SizedBox(height: 15.0,),

            Text(movie.title, 
              style: TextStyle(
                fontSize: 28.0, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 2.0
              )
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.cloud_download, size: 45, color: Colors.red[900],),
                        SizedBox(height: 5.0),
                        Text(movie.downloadSize, style: TextStyle(fontSize: 14.0, color: Colors.black87),)
                      ]
                    ),
                  ),
                ),

                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.calendar_today, size: 45, color: Colors.red[900],),
                        SizedBox(height: 5.0),
                        Text(movie.releaseDate, style: TextStyle(fontSize: 14.0, color: Colors.black87),), 
                      ]
                    ),
                  ),
                ),

                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.star_border, size: 45, color: Colors.red[900],),
                        SizedBox(height: 5.0),
                        Text(movie.rating, style: TextStyle(fontSize: 16.0, color: Colors.black87),), 
                      ]
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height:20.0),

            Text(movie.story, 
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                height: 1.5
              ),
              textAlign: TextAlign.center,
            )

          ]
        )
      ),

      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              onPressed: () async{
                final url = movie.trailer;
                if(await canLaunch(url)){
                  await launch(url);
                }
                else{
                  throw 'Could not lunch $url';
                }
              },
              color: Colors.red[900],
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.play_circle_outline),
                  Text('Watch Trailer', style: TextStyle(fontSize: 18.0))
                ]
              ),
            ),
          ),

          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              onPressed: () async{
                final imgUrl = movie.download;
                Dio dio = new Dio();

                var tempDir = await getTemporaryDirectory();
                String fullPath = tempDir.path + "/tmovie.torrent";
                print('full path $fullPath');

                download2(dio, imgUrl, fullPath);
              },
              color: Colors.grey[700],
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.file_download),
                  Text('Download', style: TextStyle(fontSize: 18.0))
                ]
              ),
            ),
          )
        ]
      ),
    );
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
   
}