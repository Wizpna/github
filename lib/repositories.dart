import "package:flutter/material.dart";
import 'package:flutter_github_trending/flutter_github_trending.dart';

class Repositories extends StatefulWidget {
  @override
  _RepositoriesState createState() => _RepositoriesState();
}

class _RepositoriesState extends State<Repositories> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Trending Languages"),
            centerTitle: true,
          ),
          body: StreamBuilder(
            stream:  getTrendingRepositories().asStream(),
            builder: (context, snapshot){
              while(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(itemCount: 7, itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text(snapshot.data[index].primaryLanguage.name),);
              },);
            },
          ),
        )
      ],
    );
  }
}
