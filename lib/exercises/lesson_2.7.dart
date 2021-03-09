import 'package:flutter/material.dart';

class IntroPage {
  String title;
  String subtitle;
  Color color;

  IntroPage({
    @required this.title,
    @required this.subtitle,
    @required this.color,
  });
}

final List<IntroPage> _introPages = [
  IntroPage(
      title: "The world",
      subtitle:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      color: Colors.blue),
  IntroPage(
      title: "Is beautiful",
      subtitle:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      color: Colors.indigo),
  IntroPage(
      title: "You know?",
      subtitle:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      color: Colors.teal),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _selectedPageIndex = 0;

  bool isLastPage() {
    return _selectedPageIndex == _introPages.length - 1;
  }

  void nextPage() {
    /// Questa [if] potrebbe anche essere eliminata perchè la funzione [isLastPage] modifica l'icon presente nelle actions dell'appBar e
    /// quella presente nell'ultima page non richiama la funzione [nextPage] con l'onPressed.
    if (!isLastPage()) {
      _pageController.animateToPage(_selectedPageIndex + 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedPageIndex = index;
      print("Selected Page: $_selectedPageIndex");
    });
  }

  void showLoginDialog(Color buttonColor) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // hintText: "Suggerimento Interno",
                    labelText: "Username",
                    icon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // hintText: "Suggerimento Interno",
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  color: buttonColor,
                  minWidth: double.infinity,
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print("Login");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _introPages[_selectedPageIndex].color,
      appBar: AppBar(
        title: Text("Welcome!"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          isLastPage()
              ? IconButton(
                  icon: Icon(Icons.check_circle),
                  onPressed: () {
                    /// Qui ho implementato il passaggio del [color] alla funzione [showLoginDialog]
                    /// così da rendere il [MaterialButton] sempre dipendente dal codice.
                    showLoginDialog(_introPages[_selectedPageIndex].color);
                  },
                )
              : IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: nextPage,
                ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: onPageChanged,
        itemCount: _introPages.length,
        itemBuilder: (context, index) {
          return IntroPageView(_introPages[index]);
        },
      ),
    );
  }
}

class IntroPageView extends StatelessWidget {
  final IntroPage introPage;

  IntroPageView(this.introPage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    introPage.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    introPage.subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
