import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Logout"),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.album_rounded,
                ),
                title: Text(
                  "Soldi",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "Mahmood, Dardust & Charlie Charles",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Drawer extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  bool _automaticLogin = false;
  void onAutomaticLogin(bool value) {
    setState(() {
      _automaticLogin = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            ListTile(
              title: Text(
                "Automatic Loging",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                "We'll remember you!",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              trailing: Switch(
                value: _automaticLogin,
                onChanged: onAutomaticLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
