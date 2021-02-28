import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carte di Credito"),
      ),
      body: Column(
        children: [
          BankView(bank: "N26"),
          BankView(bank: "Hype"),
        ],
      ),
    );
  }
}

class BankView extends StatefulWidget {
  BankView({
    @required this.bank,
  });
  final String bank;

  @override
  _BankViewState createState() => _BankViewState();
}

class _BankViewState extends State<BankView> {
  bool active = false;

  void toggleCard() {
    setState(() {
      active = !active;
    });
    print("Bank State: $active");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.credit_card),
          SizedBox(
            width: 16,
          ),
          Text(
            widget.bank,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          FlatButton(
            onPressed: toggleCard,
            child: Text(active ? "Disattiva" : "Attiva"),
          ),
        ],
      ),
      color: active ? Colors.white : Colors.grey.shade400,
    );
  }
}
