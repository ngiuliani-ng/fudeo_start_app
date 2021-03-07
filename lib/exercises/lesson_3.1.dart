import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Post {
  final String title;
  final String author;
  final String link;

  Post(this.title, this.author, this.link);

  factory Post.fromData(dynamic data) {
    final title = data["title"];
    final author = data["by"];
    final link = data["url"];

    return Post(title, author, link);
  }
}

class HomePage extends StatelessWidget {
  Future<List<Post>> downloadData() async {
    /**
     * JSON Sample: lib\json\topstories.json
     */
    final response = await http.get(Uri.parse("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"));
    final List<dynamic> postIds = json.decode(response.body);

    /**
     * Il metodo [Future.wait()] aspetta il completamento di più [Future].
     */
    return Future.wait(postIds.take(10).map((id) async {
      /**
       * JSON Sample: lib\json\26373543.json
       */
      final response = await http.get(Uri.parse("https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty"));
      return Post.fromData(json.decode(response.body));
    }));
  }

  Widget buildList(List<Post> posts) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Icon(
              Icons.exit_to_app,
              size: 26,
            ),
            title: Text(posts[index].title),
            subtitle: Text(
              posts[index].author,
              style: TextStyle(
                color: Colors.blue.shade600,
              ),
            ),
            onTap: () {
              launch(posts[index].link);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            color: Colors.grey.shade300,
          );
        },
        itemCount: posts.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFff6600),
        title: Text("Hacker News"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: downloadData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );

            default:
              if (snapshot.error != null) {
                return Center(
                  child: Icon(
                    Icons.error_outline,
                    size: 50,
                  ),
                );
              } else {
                List<Post> posts = snapshot.data;
                return buildList(posts);
              }
          }
        },
      ),
    );
  }
}
