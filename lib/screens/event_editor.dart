// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:calendar/utils/event.dart';
import 'package:calendar/utils/provider.dart';
import 'package:calendar/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventEditor extends StatefulWidget {
  const EventEditor({Key? key}) : super(key: key);

  @override
  _EventEditorState createState() => _EventEditorState();
}

class _EventEditorState extends State<EventEditor> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  DateTime now = DateTime.now();
  DateTime from = DateTime.now();
  DateTime to = DateTime.now().add(Duration(hours: 2));
  String fromDate = Utils.toDate(DateTime.now());
  String toDate = Utils.toDate(DateTime.now());
  String fromTime = Utils.toTime(DateTime.now());
  String toTime = Utils.toTime(DateTime.now().add(Duration(hours: 2)));

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
          // backgroundColor: Colors.black,
          title: Text("Add Event"),
          actions: [
            TextButton(
              // style: ButtonStyle(
              //   foregroundColor: MaterialStateProperty.all(Colors.white),
              // ),
              child: Row(
                children: [
                  Icon(Icons.done),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Save"),
                ],
              ),
              onPressed: saveEvent,
            ),
          ]),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Add an event title",
                  ),
                  controller: titleController,
                  validator: (title) => title != null && title.isEmpty
                      ? 'Title cannot be empty'
                      : null,
                )),
            buildFromTimeDropDown(),
            buildToTimeDropDown()
          ],
        ),
      ),
    );
  }

  Future? pickFromDateTime(bool isDatePicking) async {
    if (isDatePicking) {
      var fromList = await _selectTime(isDatePicking);
      final fDate = fromList[0];
      from = fromList[1];
      setState(() {
        fromDate = fDate;
      });
    } else {
      var fromList = await _selectTime(isDatePicking);
      final fTime = fromList[0];
      from = from.add(fromList[1]);
      setState(() {
        fromTime = fTime;
      });
    }
  }

  Future? pickToDateTime(bool isDatePicking) async {
    if (isDatePicking) {
      var toList = await _selectTime(isDatePicking);
      final tDate = toList[0];
      to = toList[1];
      setState(() {
        toDate = tDate;
      });
    } else {
      var toList = await _selectTime(isDatePicking);
      final tTime = toList[0];
      to = to.add(toList[1]);
      setState(() {
        toTime = tTime;
      });
    }
  }

  _selectTime(bool isDatePicking) async {
    if (isDatePicking) {
      final dateSelected = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (dateSelected == null) return null;
      final tDate = Utils.toDate(dateSelected);
      return [tDate, dateSelected];
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(now));
      if (timeOfDay == null) return null;
      final date = DateTime(2021, 3, 21);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      final selectedTime = Utils.toTime(date.add(time));
      return [selectedTime, time];
    }
  }

  Widget buildFromTimeDropDown() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(fromDate),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () {
                  pickFromDateTime(true);
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(fromTime),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () {
                  pickFromDateTime(false);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildToTimeDropDown() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(toDate),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () {
                  pickToDateTime(true);
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(toTime),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () {
                  pickToDateTime(false);
                },
              ),
            ),
          ],
        ),
      );

  Future saveEvent() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final colors = [Colors.red, Colors.pink, Colors.yellow, Colors.blue];
      var random = Random();
      final index = random.nextInt(colors.length);
      final event = Event(
          title: titleController.text,
          from: from,
          to: to,
          backgroundColor: colors[index]);
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);
      Navigator.of(context).pop();
    }
  }
}
