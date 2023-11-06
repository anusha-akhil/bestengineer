import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/screen/Enquiry/dailyreport_edit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({super.key});

  @override
  State<DailyReport> createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> validph = ValueNotifier(false);
  DateFind dateFind = DateFind();
  DateTime d = DateTime.now();
  String? date;
  String? today;
  // bool isEdit = false;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validph.value = false;
    visiblename.value = false;
    visibleph.value = false;
    name.clear();
    adress.clear();
    phone.clear();
    print("d----------$date");

    date = DateFormat('dd-MM-yyyy').format(d);

    today = DateFormat('dd-MM-yyyy').format(selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = DateFormat('dd-MM-yyyy').format(selectedDate);
        Provider.of<Controller>(context, listen: false)
            .setDate(date.toString());

        Provider.of<Controller>(context, listen: false)
            .getdailyReport(context, date.toString());
      });
    }
  }

  String? row;
  String? custId;

  ValueNotifier<bool> visiblename = ValueNotifier(false);
  ValueNotifier<bool> visibleph = ValueNotifier(false);
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController remark = TextEditingController();

  TextEditingController phone = TextEditingController();
  var cusout;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Consumer<Controller>(
          builder: (context, value, child) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Autocomplete<Map<String, dynamic>>(
                          optionsBuilder: (TextEditingValue values) {
                            if (values.text.isEmpty) {
                              return [];
                            } else {
                              cusout = value.customerListFordailyReport.where(
                                  (suggestion) => suggestion["company_name"]
                                      .toLowerCase()
                                      .contains(values.text.toLowerCase()));
                              if (cusout == null || cusout.isEmpty) {
                                Provider.of<Controller>(context, listen: false)
                                    .setSelectedCustomer(false);
                              } else {
                                Provider.of<Controller>(context, listen: false)
                                    .setSelectedCustomer(true);
                              }

                              print(value.customerListFordailyReport.where(
                                  (suggestion) => suggestion["company_name"]
                                      .toLowerCase()
                                      .contains(
                                        values.text.toLowerCase(),
                                      )));

                              return value.customerListFordailyReport.where(
                                  (suggestion) =>
                                      suggestion["company_name"]
                                          .toLowerCase()
                                          .contains(
                                            values.text.toLowerCase(),
                                          ) ||
                                      suggestion["phone_1"].contains(
                                        values.text.toLowerCase(),
                                      ));
                            }
                          },
                          displayStringForOption:
                              (Map<String, dynamic> option) =>
                                  option["company_name"],
                          fieldViewBuilder: (BuildContext context,
                              fieldText,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted) {
                            // Provider.of<Controller>(context, listen: false)
                            //     .customerControllerSale = fieldText;
                            return Container(
                              // height: size.height * 0.05,
                              child: TextFormField(
                                validator: (text) {
                                  if (fieldText.text == null ||
                                      fieldText.text.isEmpty) {
                                    return null;
                                  }
                                },
                                // validator: (text) {
                                //   if (text == null || text.isEmpty) {
                                //     visible.value = true;
                                //     return visible.value.toString();
                                //     // return 'Please Enter Phone Number';
                                //   } else {
                                //     visible.value = false;
                                //   }
                                //   return null;
                                // },
                                // scrollPadding: EdgeInsets.only(
                                //     bottom: topInsets + size.height * 0.4),
                                onChanged: (value) {
                                  name.text = fieldText.text;
                                  visiblename.value = false;
                                  adress.clear();
                                  custId = "";
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setSelectedCustomer(false);
                                },
                                // scrollPadding: EdgeInsets.only(
                                //     top: 500,),
                                maxLines: null,
                                decoration: InputDecoration(
                                  // border: InputBorder.none,
                                  border: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 14),
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'Customer',
                                  hintStyle: TextStyle(fontSize: 14),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      fieldText.clear();
                                      adress.clear();
                                      phone.clear();
                                      name.clear();
                                      value.dropSelected = null;
                                      custId = "";
                                      remark.clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                                controller: fieldText,
                                // controller:
                                //     name.text.isNotEmpty ? name : fieldText,
                                focusNode: fieldFocusNode,
                                style: TextStyle(
                                  fontSize: 16, color: Colors.grey[800],
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<Map<String, dynamic>>
                                  onSelected,
                              Iterable<Map<String, dynamic>> options) {
                            print("option----${options}");
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                // width: 400,
                                // height: size.height * 0.3,
                                // color: Colors.grey[200],
                                child: Container(
                                  width: 300,
                                  color: Colors.grey[200],
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final Map<String, dynamic> option =
                                          options.elementAt(index);
                                      return Column(
                                        children: [
                                          ListTile(
                                            // tileColor: Colors.amber,
                                            onTap: () {
                                              onSelected(option);
                                              print("optionaid------$option");

                                              name.text = option["company_name"]
                                                  .toString();
                                              adress.text =
                                                  option["company_add1"]
                                                      .toString();
                                              // phone.text =
                                              //     option["phone_1"].toString();

                                              custId = option["customer_id"]
                                                  .toString();
                                              // value.dropSelected =
                                              //     option["priority"]
                                              //         .toString();
                                            },
                                            title: Text(
                                                option["company_name"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                            subtitle: Text(
                                              option["phone_1"].toString(),
                                            ),
                                          ),
                                          Divider()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: visiblename,
                                  builder: (BuildContext context, bool v,
                                      Widget? child) {
                                    return Visibility(
                                      visible: v,
                                      child: Text(
                                        "Please choose a  Customer",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                // margin:
                                //     EdgeInsets.only(left: 6, right: 6),
                                child: TextField(
                                  controller: adress,
                                  onChanged: (val) {
                                    print("val----$val");
                                    // if (val != oldDesc) {
                                    //   // Provider.of<Controller>(context,
                                    //   //         listen: false)
                                    //   //     .setaddNewItem(true);
                                    // }
                                  },
                                  style: TextStyle(color: Colors.grey[800]),
                                  // controller: value.desc[index],
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 14),
                                    prefixIcon: Icon(Icons.info),
                                    hintText: "Customer Info",
                                    hintStyle: TextStyle(fontSize: 14),
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                ),
                              ),
                            ),
                            //
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                // transform: Matrix4.translationValues(0.0, 8, 0.0),
                                // height: size.height * 0.05,
                                child: TextFormField(
                                  onChanged: (va) {
                                    visibleph.value = false;
                                  },
                                  controller: phone,
                                  style: TextStyle(color: Colors.grey[800]),
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.red,
                                    )),
                                    // border: InputBorder.none,
                                    hintText: "Contact Number",
                                    hintStyle: TextStyle(fontSize: 14),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 14),
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLines: null,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: visibleph,
                                      builder: (BuildContext context, bool v,
                                          Widget? child) {
                                        return Visibility(
                                          visible: v,
                                          child: Text(
                                            "Please Enter Contact Number",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                // margin:
                                //     EdgeInsets.only(left: 6, right: 6),
                                child: TextField(
                                  controller: remark,
                                  onChanged: (val) {
                                    print("val----$val");
                                    // if (val != oldDesc) {
                                    //   // Provider.of<Controller>(context,
                                    //   //         listen: false)
                                    //   //     .setaddNewItem(true);
                                    // }
                                  },
                                  style: TextStyle(color: Colors.grey[800]),
                                  // controller: value.desc[index],
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 14),
                                    prefixIcon: Icon(Icons.note),
                                    hintText: "Type Remark",
                                    hintStyle: TextStyle(fontSize: 14),
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: P_Settings.loginPagetheme,
                              ),
                              onPressed: () {
                                if (name.text == null || name.text.isEmpty) {
                                  visiblename.value = true;
                                } else if (phone.text == null ||
                                    phone.text.isEmpty) {
                                  visibleph.value = true;
                                } else if (phone.text.length != 10) {
                                  validph.value = true;
                                } else {
                                  validph.value = false;
                                  visibleph.value = false;
                                  visiblename.value = false;
                                  String? c;
                                  if (custId == null || custId == "") {
                                    c = "0";
                                  } else {
                                    c = custId;
                                  }

                                  if (value.selectedCustomer == false) {
                                    c = "0";
                                  }

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .saveDailyReport(
                                          context,
                                          c.toString(),
                                          name.text,
                                          phone.text,
                                          adress.text,
                                          today.toString(),
                                          remark.text,
                                          "0",
                                          "0");
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getdailyReport(context, date.toString());
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setDate(today.toString());
                                  // name.clear();
                                  // remark.clear();
                                  // phone.clear();
                                  // adress.clear();
                                  // custId = "";
                                }
                              },
                              child: Text(
                                "Add".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          // color: P_Settings.loginPagetheme,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        value.fromDate.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                value.dailyReportList.length == 0
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Daily Report List",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: P_Settings.loginPagetheme,
                                fontSize: 15),
                          )
                        ],
                      ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                value.isdailyreportLoading
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.dailyReportList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          value.dailyReportList[index]
                                                  ["customer_name"]
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone, size: 15),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Flexible(
                                          child: Text(
                                              value.dailyReportList[index]
                                                  ["phone"])),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.business, size: 15),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Flexible(
                                          child: Text(
                                              value.dailyReportList[index]
                                                  ["cust_addrs"])),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      date == today
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DailyReportEdit(
                                                            map: value
                                                                    .dailyReportList[
                                                                index],
                                                          )),
                                                );
                                                // setState(() {
                                                //   custId =
                                                //       value.dailyReportList[index]
                                                //           ["customer_id"];
                                                //   row = value.dailyReportList[index]
                                                //       ["dr_id"];
                                                //   isEdit = true;
                                                //   name.text =
                                                //       value.dailyReportList[index]
                                                //           ["customer_name"];
                                                //   adress.text =
                                                //       value.dailyReportList[index]
                                                //           ["cust_addrs"];
                                                //   phone.text =
                                                //       value.dailyReportList[index]
                                                //           ["phone"];
                                                //   remark.text =
                                                //       value.dailyReportList[index]
                                                //           ["remark"];
                                                // });
                                              },
                                              child: Row(
                                                children: [
                                                  Text("Edit"),
                                                  Icon(
                                                    Icons.edit,
                                                    size: 15,
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      today == date
                                          ? InkWell(
                                              onTap: () {
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .saveDailyReport(
                                                        context,
                                                        value.dailyReportList[
                                                                index]
                                                            ["customer_id"],
                                                        name.text,
                                                        phone.text,
                                                        adress.text,
                                                        value.dailyReportList[
                                                            index]["r_date"],
                                                        remark.text,
                                                        "2",
                                                        value.dailyReportList[
                                                            index]["dr_id"]);

                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .getdailyReport(context,
                                                        date.toString());
                                              },
                                              child: Row(
                                                children: [
                                                  Text("Remove"),
                                                  Icon(Icons.delete, size: 15)
                                                ],
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
              ],
            );
          },
        ),
      ),
    );
  }
}
