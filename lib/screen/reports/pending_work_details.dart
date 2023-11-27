import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingWorkDetails extends StatefulWidget {
  String title;
  PendingWorkDetails({required this.title});

  @override
  State<PendingWorkDetails> createState() => _PendingWorkDetailsState();
}

class _PendingWorkDetailsState extends State<PendingWorkDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: P_Settings.loginPagetheme,
        title: Text(
          "Quot No : ${widget.title.toString()}",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<QuotationController>(
        builder: (context, value, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: value.pendingworkDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "User  : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                        child: Text(
                                      value.pendingworkDetails[index]["s_user"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                value.pendingworkDetails[index]["s_remrks"] ==
                                            null ||
                                        value
                                            .pendingworkDetails[index]
                                                ["s_remrks"]
                                            .isEmpty
                                    ? Container()
                                    : Row(
                                        children: [
                                          Icon(
                                            Icons.note,
                                            size: 16,
                                            color: Colors.purpleAccent,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Remarks : ",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Flexible(
                                              child: Text(
                                            value.pendingworkDetails[index]
                                                ["s_remrks"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))
                                        ],
                                      ),
                                SizedBox(
                                  height: 4,
                                ),
                                value.pendingworkDetails[index]["s_date"] ==
                                            null ||
                                        value
                                            .pendingworkDetails[index]["s_date"]
                                            .isEmpty
                                    ? Container()
                                    : Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            size: 16,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Date : ",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Flexible(
                                            child: Text(
                                              value.pendingworkDetails[index]
                                                  ["s_date"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
