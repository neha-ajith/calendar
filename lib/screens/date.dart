// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:calendar/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Date extends StatelessWidget {
  final CalendarTapDetails calendarTapDetails;
  Date(this.calendarTapDetails);

  @override
  Widget build(BuildContext context) {
    final events = calendarTapDetails.appointments;
    return Scaffold(
        appBar: AppBar(
          title: Text(Utils.toDate(calendarTapDetails.date)),
        ),
        body: ListView.builder(
          itemCount: events!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  color: events[index].backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(
                        events[index].title,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "From:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Utils.toDate(events[index].from)),
                          Text(Utils.toTime(events[index].from)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "To:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Utils.toDate(events[index].to)),
                          Text(Utils.toTime(events[index].to))
                        ],
                      ),
                    ]),
                  )),
            );
          },
        ));
  }
}

// print(calendarTapDetails.appointments![0].title);
