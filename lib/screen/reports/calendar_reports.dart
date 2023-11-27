import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/screen/reports/pendingworks_report.dart';
import 'package:bestengineer/screen/reports/userlog_reports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarReports extends StatefulWidget {
  const CalendarReports({super.key});

  @override
  State<CalendarReports> createState() => _CalendarReportsState();
}

class _CalendarReportsState extends State<CalendarReports> {
  DateTime today = DateTime.now();
  String? val;
  void onselectedDay(DateTime day, DateTime foucsday) {
    setState(() {
      today = foucsday;
    });
    String date = DateFormat('yyyy-MM-dd').format(today);
    val = "";
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
                title: Text(
                  "Choose Report Type",
                  style: TextStyle(fontSize: 17),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      title: Text("Pending Work"),
                      value: "2",
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          print("val-----$value");
                          val = value.toString();
                        });
                        Provider.of<QuotationController>(context, listen: false)
                            .fetchCalendarReports(
                          date,
                          val.toString(),
                          context,
                        );

                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingWorkReport()),
                        );
                      },
                    ),
                    RadioListTile(
                      title: Text("UserLog"),
                      value: "1",
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          print("val-----$value");
                          val = value.toString();
                        });
                        Provider.of<QuotationController>(context, listen: false)
                            .fetchCalendarReports(
                          date,
                          val.toString(),
                          context,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserLogReports()),
                        );
                      },
                    ),
                  ],
                ));
          });
        });
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //           title: Text(
    //             "Choose Report Type",
    //             style: TextStyle(fontSize: 15),
    //           ),
    //           content: Column(
    //             children: [
    //               RadioListTile(
    //                 title: Text("Pending Work"),
    //                 value: "pending",
    //                 groupValue: val,
    //                 onChanged: (value) {
    //                   setState(() {
    //                     print("val-----$value");
    //                     val = value.toString();
    //                   });
    //                 },
    //               ),
    //               RadioListTile(
    //                 title: Text("UserLog"),
    //                 value: "userlog",
    //                 groupValue: val,
    //                 onChanged: (value) {
    //                   setState(() {
    //                     print("val-----$value");

    //                     val = value.toString();
    //                   });
    //                 },
    //               ),
    //             ],
    //           ));
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Text("selected day =" + today.toString().split(" ")[0]),
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
