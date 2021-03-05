import 'package:flutter/material.dart';

class Day {
  final int nr;
  String task;

  Day(this.nr);
}

class Month {
  final String name;
  List<Day> days;

  Month(this.name, int daysNr) {
    days = List.generate(daysNr, (dayNr) => Day(dayNr + 1));
  }
}

final months = [
  Month("Gennaio", 31),
  Month("Febbario", 28),
  Month("Marzo", 31),
  Month("Aprile", 30),
  Month("Maggio", 31),
  Month("Giugno", 30),
  Month("Luglio", 31),
  Month("Agosto", 31),
  Month("Settembre", 30),
  Month("Ottobre", 31),
  Month("Novembre", 30),
  Month("Dicembre", 31),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();
  int _selectedMonthIndex = 0;

  void onTaskSubmit(Day day) {
    String task = _taskController.text.trim();
    setState(() {
      day.task = task;
      _taskController.clear();
    });
    Navigator.of(context).pop();
  }

  void onMonthSelected(int index) {
    setState(() {
      _selectedMonthIndex = index;
    });
    Navigator.of(context).pop();
  }

  void onDaySelected(BuildContext context, Day day) {
    _taskController.clear();
    showBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          width: double.infinity,
          color: Colors.grey.shade200,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    day.nr.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    months[_selectedMonthIndex].name,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: "Add here a task!",
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                MaterialButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  height: 40,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    onTaskSubmit(day);
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
      appBar: AppBar(
        title: Text("Calendar"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                onDaySelected(context, months[_selectedMonthIndex].days[index]);
              },
              title: Text(months[_selectedMonthIndex].days[index].nr.toString()),
              subtitle: Text(months[_selectedMonthIndex].days[index].task ?? "..."),
            ),
          );
        },
        itemCount: months[_selectedMonthIndex].days.length,
      ),
      drawer: Container(
        width: 300,
        color: Colors.white,
        child: SafeArea(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                color: index == _selectedMonthIndex ? Colors.grey.shade200 : Colors.transparent,
                child: ListTile(
                  onTap: () {
                    onMonthSelected(index);
                  },
                  title: Text(months[index].name),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              );
            },
            itemCount: months.length,
          ),
        ),
      ),
    );
  }
}
