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
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: SideBar(),
          ),
          Positioned(
            left: 0,
            right: 100,
            top: 0,
            bottom: 0,
            child: Body(),
          ),
        ],
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: Colors.grey.shade200,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contacts",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Contact(
              name: "Nicolò Giulani",
              address: "Riccione, Italy",
            ),
            Contact(
              name: "Nicolò Giulani",
              address: "Riccione, Italy",
            ),
            Contact(
              name: "Nicolò Giulani",
              address: "Riccione, Italy",
            ),
            Contact(
              name: "Nicolò Giulani",
              address: "Riccione, Italy",
            ),
            Contact(
              name: "Nicolò Giulani",
              address: "Riccione, Italy",
            ),
          ],
        ),
      ),
    );
  }
}

class Contact extends StatelessWidget {
  Contact({@required this.name, @required this.address});
  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          address,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        leading: Icon(
          Icons.person_rounded,
          color: Colors.indigo,
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Carte di Credito"),
//       ),
//       body: Column(
//         children: [
//           BankView(bank: "N26"),
//           BankView(bank: "Hype"),
//         ],
//       ),
//     );
//   }
// }
//
// class BankView extends StatefulWidget {
//   BankView({
//     @required this.bank,
//   });
//   final String bank;
//
//   @override
//   _BankViewState createState() => _BankViewState();
// }
//
// class _BankViewState extends State<BankView> {
//   bool active = false;
//
//   void toggleCard() {
//     setState(() {
//       active = !active;
//     });
//     print("Bank State: $active");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Row(
//         children: [
//           Icon(Icons.credit_card),
//           SizedBox(
//             width: 16,
//           ),
//           Text(
//             widget.bank,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Expanded(
//             child: SizedBox(),
//           ),
//           FlatButton(
//             onPressed: toggleCard,
//             child: Text(active ? "Disattiva" : "Attiva"),
//           ),
//         ],
//       ),
//       color: active ? Colors.white : Colors.grey.shade400,
//     );
//   }
// }
