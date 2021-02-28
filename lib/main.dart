import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  void onPressed() {
    print("onPressed");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("App - Flutter Start"),
        ),
        body: RaisedButton(
          child: Text(
            "My Raised Button",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: this.onPressed,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: this.onPressed,
        ),
      ),
    );
  }
}
