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

/// La keywords [async] la aggiungiamo ad una funzione quando non sappiamo già a priori quando questa finirà.
/// La keywords [await] la aggiungiamo ad un'altra funzione che aspetta il completamento di una con l'[async].
class HomePage extends StatelessWidget {
  Future<List<Post>> downloadData() async {
    final response = await http.get(Uri.parse("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"));

    /// [dynamic] raccoglie qualsiasi altro tipo presente in Flutter, in questo caso è come dire: non conosco il tipo di ritorno.
    final List<dynamic> postIds = json.decode(response.body);

    /// Il metodo [Future.wait()] aspetta il completamento di più metodi asincroni.
    return Future.wait(postIds.take(10).map((id) async {
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

      /// Il [FutureBuilder()] ci permette di avere un componente di caricamento mentre scarichiamo i dati
      /// e solo successivamente, quando questi saranno disponibili, di mostrarli all'utente
      /// con un'altro componete: nel nostro caso con la [ListView.separated()].
      body: FutureBuilder(
        future: downloadData(),

        /// [snapshot] contiene varie informazioni sullo stato corrente e sui dati scaricati.
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
                    size: 35,
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
