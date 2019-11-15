import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_github_trending/flutter_github_trending.dart';
import 'package:github/repositories.dart';

main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub',
      theme: ThemeData(
          primaryColor: Colors.black
      ),
      home: Repositories(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var repos1, repos2;
  bool isLoading = false;

  trendingRepositories() async {
    var trendingRepos = await getTrendingRepositories();
    repos1 = (trendingRepos[0].owner);
    repos2 = (trendingRepos[1].owner);
    print("Trending repo is " + repos1);
    print("Trending repo is " + repos2);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("GitHub"),
            ),
            body: StreamBuilder(
                stream: getTrendingRepositories().asStream(),
                builder: (context, snapshot) {
                  while (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(snapshot.data[index].owner),);
                      });
                }
            )
        ),
        Center(
            child: (isLoading == true)
                ? CircularProgressIndicator()
                : Container(
              height: 0,
              width: 0,
            )
        )
      ],
    );
    ;
  }
}
