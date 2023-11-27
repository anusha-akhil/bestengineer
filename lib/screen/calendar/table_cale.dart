import 'package:bestengineer/components/commonColor.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCaletest extends StatefulWidget {
  const TableCaletest({super.key});

  @override
  State<TableCaletest> createState() => _TableCaletestState();
}

class _TableCaletestState extends State<TableCaletest> {
  DateTime today = DateTime.now();

  void onselectedDay(DateTime day, DateTime foucsday) {
    setState(() {
      today = foucsday;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Column(
        children: [
          Text("selected day =" + today.toString().split(" ")[0]),
          Container(
              child: TableCalendar(
            calendarStyle: CalendarStyle(
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
            ),
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            firstDay: DateTime.utc(2010),
            focusedDay: today,
            lastDay: DateTime.utc(2030),
            onDaySelected: onselectedDay,
            selectedDayPredicate: (day) => isSameDay(day, today),
          )),
        ],
      ),
    );
  }
}
