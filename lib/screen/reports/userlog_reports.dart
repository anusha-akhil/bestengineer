import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class UserLogReports extends StatefulWidget {
  const UserLogReports({super.key});

  @override
  State<UserLogReports> createState() => _UserLogReportsState();
}

class _UserLogReportsState extends State<UserLogReports> {
  TextEditingController seacrh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "UserLog Reports",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
          ),
          backgroundColor: P_Settings.loginPagetheme,
          leading: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Consumer<QuotationController>(
          builder: (BuildContext context, value, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.05,
                  child: TextField(
                    controller: seacrh,
                    onChanged: (v) => value.searchuserLog(v, "1"),
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: 'search here',
                        hintStyle: TextStyle(fontSize: 13),
                        suffixIcon: InkWell(
                          onTap: () {
                            seacrh.clear();
                            value.setIsSearch(false, "1");
                          },
                          child: Icon(
                            Icons.close,
                            size: 19,
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: value.calendarWidget.length,
                    itemBuilder: (context, int index) {
                      return value.calendarWidget[index];
                    }),
              ),
            ],
          ),
        ));
  }
}
