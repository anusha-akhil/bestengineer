import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyReportEdit extends StatefulWidget {
  Map<String, dynamic> map;
  DailyReportEdit({super.key, required this.map});

  @override
  State<DailyReportEdit> createState() => _DailyReportEditState();
}

class _DailyReportEditState extends State<DailyReportEdit> {
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? date;
  String? c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.map['customer_name'];
    phone.text = widget.map['phone'];
    remark.text = widget.map['remark'];
    adress.text = widget.map['cust_addrs'];
    date = widget.map["r_date"];
    c = widget.map["customer_id"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Provider.of<Controller>(context, listen: false)
                  .getdailyReport(context, date.toString());
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
              ),
              controller: name,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.info),
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
              ),
              controller: adress,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
              ),
              controller: phone,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note),
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
              ),
              controller: remark,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: P_Settings.loginPagetheme),
                onPressed: () {
                  Provider.of<Controller>(context, listen: false)
                      .saveDailyReport(
                          context,
                          c.toString(),
                          name.text,
                          phone.text,
                          adress.text,
                          date!,
                          remark.text,
                          "1",
                          "0");
                },
                child: Text(
                  "EDIT",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
