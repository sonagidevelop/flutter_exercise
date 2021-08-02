import 'dart:ui';

import 'event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// void main() {
//   initializeDateFormatting().then((_) => runApp(MyApp()));
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarView(title: 'MyCalendar'),
    );
  }
}

class CalendarView extends StatefulWidget {
  CalendarView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

// class MyTime {
//   final
// }

class _CalendarViewState extends State<CalendarView> {
  //오류시 확인필요

  Map<DateTime, List<Event>>? selectedEvents;
  // late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEvnetsfromDay(DateTime date) {
    //오류시 확인필요

    return selectedEvents?[date] ?? [];
  }

  // @override
  // void initState() {
  //   super.initState();

  //   _selectedDay = _focusedDay;
  //   _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  // }

  // @override
  // void dispose() {
  //   _selectedEvents.dispose();
  //   super.dispose();
  // }

  // List<Event> _getEventsForDay(DateTime day) {
  //   return events[day] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    final urlImage1 = 'assets/001.png';
    final urlImage2 = 'assets/002.png';
    final urlImage3 = 'assets/003.png';
    int index = 3;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            // locale: 'ko_KR',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,

            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },

            //네비게이터위치

            onDaySelected: (selectedDay, focusedDay) {
              if (_selectedDay == selectedDay) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SecondPage()));
              }
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              headerPadding: EdgeInsets.all(20),
              headerMargin: EdgeInsets.only(top: 40),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(), weekdayStyle: TextStyle()),
            rowHeight: 90,
            daysOfWeekHeight: 60,

            //Styles
            calendarStyle: CalendarStyle(

                //꼭기억하자
                selectedDecoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(urlImage2),
                  ),
                ),
                outsideDaysVisible: false,
                cellMargin: EdgeInsets.all(1),
                todayTextStyle: TextStyle(height: -3),
                todayDecoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 22,
                  height: -2,
                  fontWeight: FontWeight.bold,
                ),
                // selectedDecoration: BoxDecoration(image: DecorationImage(image: urlIm)),

                weekendTextStyle: TextStyle(
                  color: Colors.red,
                  height: -3,
                ),
                defaultTextStyle: TextStyle(height: -3),
                rowDecoration: BoxDecoration(),
                weekendDecoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle,
                ),
                defaultDecoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle,
                )),

            // calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
            //   if (day.weekday == DateTime.sunday) {
            //     final text = DateFormat.E().format(day);

            //     return Center(
            //       child: Text(
            //         text,
            //         style: TextStyle(color: Colors.red),
            //       ),
            //     );
            //   }
            // }),
            eventLoader: _getEvnetsfromDay,
          ),
          TextButton(
            onPressed: () {},
            child: Image.asset(
              urlImage2,
              height: 60,
              width: 60,
            ),
          ),
        ],
      )),
    );
  }
}

// class Todo {
//   final String title;
//   final String description;

//   Todo(this.title, this.description);
// }

//SecondPage

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // TextEditingController _eventController = TextEditingController();

  int index = 3;

  @override
  Widget build(BuildContext context) {
    final urlImage1 = 'assets/001.png';
    final urlImage2 = 'assets/002.png';
    final urlImage3 = 'assets/003.png';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          FormBuilder(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      child: Image.asset(
                        urlImage1,
                        width: 60,
                        height: 60,
                      ),
                      onPressed: () {
                        index = 0;
                        setState(() {
                          width:
                          150;
                          height:
                          150;
                        });
                      },
                    ),
                    FlatButton(
                      child: Image.asset(
                        urlImage2,
                        width: 60,
                        height: 60,
                      ),
                      onPressed: () {
                        index = 1;
                        setState(() {
                          width:
                          150;
                          height:
                          150;
                        });
                      },
                    ),
                    FlatButton(
                      child: Image.asset(
                        urlImage3,
                        width: 60,
                        height: 60,
                      ),
                      onPressed: () {
                        index = 2;
                        setState(() {
                          width:
                          150;
                          height:
                          150;
                        });
                      },
                    ),
                    FlatButton(
                      child: Icon(Icons.favorite),
                      onPressed: () {
                        index = 3;
                      },
                    )
                  ],
                ),
                // FormBuilderField(
                //   builder: _eventController,
                //   name: _eventController,
                // ),
                FormBuilderDateTimePicker(
                  name: "date",
                  initialValue: DateTime.now(),
                  fieldHintText: "Add Date",
                  inputType: InputType.date,
                  format: DateFormat('EEEE, dd MMMM, yyyy'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.calendar_today_sharp),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  name: "title",
                  decoration: InputDecoration(
                    hintText: "Add Title",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 48.0),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  name: "description",
                  maxLines: 10,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Details",
                    prefixIcon: Icon(Icons.short_text),
                  ),
                ),
                Divider(),
                FormBuilderSwitch(
                  name: "public",
                  title: Text("Public"),
                  initialValue: false,
                  controlAffinity: ListTileControlAffinity.leading,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class TableBasicsExample extends StatefulWidget {
//   @override
//   _TableBasicsExampleState createState() => _TableBasicsExampleState();
// }

// class _TableBasicsExampleState extends State<TableBasicsExample> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TableCalendar - Basics'),
//       ),
//       body: TableCalendar(
//         firstDay: DateTime.utc(2010, 10, 16),
//         lastDay: DateTime.utc(2030, 3, 14),
//         focusedDay: _focusedDay,
//         calendarFormat: _calendarFormat,
//         selectedDayPredicate: (day) {
//           // Use `selectedDayPredicate` to determine which day is currently selected.
//           // If this returns true, then `day` will be marked as selected.

//           // Using `isSameDay` is recommended to disregard
//           // the time-part of compared DateTime objects.
//           return isSameDay(_selectedDay, day);
//         },
//         onDaySelected: (selectedDay, focusedDay) {
//           if (!isSameDay(_selectedDay, selectedDay)) {
//             // Call `setState()` when updating the selected day
//             setState(() {
//               _selectedDay = selectedDay;
//               _focusedDay = focusedDay;
//             });
//           }
//         },
//         onFormatChanged: (format) {
//           if (_calendarFormat != format) {
//             // Call `setState()` when updating calendar format
//             setState(() {
//               _calendarFormat = format;
//             });
//           }
//         },
//         onPageChanged: (focusedDay) {
//           // No need to call `setState()` here
//           _focusedDay = focusedDay;
//         },
//       ),
//     );
//   }
// }
