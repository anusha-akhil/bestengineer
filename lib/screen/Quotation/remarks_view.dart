import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemarksView extends StatefulWidget {
  const RemarksView({super.key});
  @override
  State<RemarksView> createState() => _RemarksViewState();
}

class _RemarksViewState extends State<RemarksView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Consumer<QuotationController>(
        builder: (context, value, child) => Row(
          children: [
            Container(
              width: size.width * 0.5,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    "Staff side",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 15),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: value.usergpother.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: value.usergpother[index]["remark"] == null ||
                                    value.usergpother[index]["remark"].isEmpty
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color.fromARGB(
                                              255, 105, 104, 104),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.usergpother[index]["NAME"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                value.usergpother[index]
                                                    ["remark"],
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              value.usergpother[index]
                                                  ["added_on"],
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        )
                                      ],
                                    ),
                                  ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    "Office Side",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 15),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: value.usergp1.length,
                        itemBuilder: (context, index) {
                          return Container(
                              child: value.usergp1[index]["remark"] == null ||
                                      value.usergp1[index]["remark"].isEmpty
                                  ? Container()
                                  : Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Color.fromARGB(
                                                255, 105, 104, 104),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                value.usergp1[index]["NAME"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  value.usergp1[index]
                                                      ["remark"],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                value.usergp1[index]
                                                    ["added_on"],
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          )
                                        ],
                                      ),
                                    ));
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
