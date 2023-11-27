import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/screen/reports/pending_work_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PendingWorkReport extends StatefulWidget {
  const PendingWorkReport({super.key});

  @override
  State<PendingWorkReport> createState() => _PendingWorkReportState();
}

class _PendingWorkReportState extends State<PendingWorkReport> {
  TextEditingController seacrh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pending works",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
        ),
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
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<QuotationController>(
        builder: (context, value, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.05,
                child: TextField(
                  controller: seacrh,
                  onChanged: (v) => value.searchuserLog(v, "2"),
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
                          value.setIsSearch(false, "2");
                        },
                        child: Icon(
                          Icons.close,
                          size: 19,
                        ),
                      )),
                ),
              ),
            ),
            value.isSearch ? filteredreportList() : reportList()
          ],
        ),
      ),
    );
  }

  Widget reportList() {
    return Expanded(
      child: Consumer<QuotationController>(
        builder: (context, value, child) => ListView.builder(
            itemCount: value.pendingworklist.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    value.fetchQuotationDetails(
                        value.pendingworklist[index]["s_invoice_id"],
                        value.pendingworklist[index]["type"],
                        context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PendingWorkDetails(
                                title: value.pendingworklist[index]
                                    ["s_invoice_no"],
                              )),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          value.pendingworklist[index]["s_invoice_no"] ==
                                      null ||
                                  value.pendingworklist[index]["s_invoice_no"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.code,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Quotation No : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                        child: Text(
                                      value.pendingworklist[index]
                                          ["s_invoice_no"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.pendingworklist[index]["s_customer_name"] ==
                                      null ||
                                  value
                                      .pendingworklist[index]["s_customer_name"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.purpleAccent,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Customer Name : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                        child: Text(
                                      value.pendingworklist[index]
                                          ["s_customer_name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.pendingworklist[index]["next_contact_date"] ==
                                      null ||
                                  value
                                      .pendingworklist[index]
                                          ["next_contact_date"]
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
                                      "Next Date : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value.pendingworklist[index]
                                            ["next_contact_date"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.pendingworklist[index]["prepared_by"] == null ||
                                  value.pendingworklist[index]["prepared_by"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Prepared By : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value.pendingworklist[index]
                                            ["prepared_by"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.pendingworklist[index]["last_attnd_stf"] ==
                                      null ||
                                  value.pendingworklist[index]["last_attnd_stf"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Last Attend Staff : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value.pendingworklist[index]
                                            ["last_attnd_stf"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.pendingworklist[index]["status"] == null ||
                                  value.pendingworklist[index]["status"].isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.note,
                                      size: 16,
                                      color:
                                          const Color.fromARGB(255, 38, 0, 255),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Status  : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value.pendingworklist[index]["status"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.pendingworklist[index]["added_on"] == null ||
                                  value.pendingworklist[index]["added_on"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: const Color.fromARGB(
                                          255, 7, 255, 222),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Added on : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                        child: Text(
                                      value.pendingworklist[index]["added_on"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
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
    );
  }

  Widget filteredreportList() {
    return Expanded(
      child: Consumer<QuotationController>(
        builder: (context, value, child) => ListView.builder(
            itemCount: value.filteredList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    value.fetchQuotationDetails(
                        value.filteredList[index]["s_invoice_id"],
                        value.filteredList[index]["type"],
                        context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PendingWorkDetails(
                                title: value.filteredList[index]
                                    ["s_invoice_no"],
                              )),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          value.filteredList[index]["s_invoice_no"] == null ||
                                  value.filteredList[index]["s_invoice_no"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.code,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Quotation No : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                        child: Text(
                                      value.filteredList[index]["s_invoice_no"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.filteredList[index]["s_customer_name"] ==
                                      null ||
                                  value.filteredList[index]["s_customer_name"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.purpleAccent,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Customer Name : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                        child: Text(
                                      value.filteredList[index]
                                          ["s_customer_name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.filteredList[index]["next_contact_date"] ==
                                      null ||
                                  value.filteredList[index]["next_contact_date"]
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
                                      "Next Date : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value.filteredList[index]
                                            ["next_contact_date"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.filteredList[index]["prepared_by"] == null ||
                                  value.filteredList[index]["prepared_by"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Prepared By : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value.filteredList[index]
                                            ["prepared_by"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.filteredList[index]["last_attnd_stf"] == null ||
                                  value.filteredList[index]["last_attnd_stf"]
                                      .isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Last Attend Staff : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value.filteredList[index]
                                            ["last_attnd_stf"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.filteredList[index]["status"] == null ||
                                  value.filteredList[index]["status"].isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.note,
                                      size: 16,
                                      color:
                                          const Color.fromARGB(255, 38, 0, 255),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Status  : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value.filteredList[index]["status"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 4,
                          ),
                          value.filteredList[index]["added_on"] == null ||
                                  value.filteredList[index]["added_on"].isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: const Color.fromARGB(
                                          255, 7, 255, 222),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Added on : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Flexible(
                                        child: Text(
                                      value.filteredList[index]["added_on"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
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
    );
  }
}
