import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/widgets/alertCommon/deletePopup.dart';
import 'package:bestengineer/widgets/alertCommon/set_schedule_date_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PendingQuotationList {
  final _formKey = GlobalKey<FormState>();
  DateFind dateFind = DateFind();
  String? todaydate;
  String? selected;
  var cusout;
  String? custId;
  Future buildPendingPopup(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size;
    todaydate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return showDialog(
        useSafeArea: true,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   "Pending List",
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                // ),
                IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ),

            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.grey[100],
            content: Consumer<QuotationController>(
              builder: (context, value, child) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                  child: Container(
                    width: double.maxFinite,
                    child: value.isPendingQuotList
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SpinKitCircle(
                                color: P_Settings.loginPagetheme,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              value.pending_quotation_list.length > 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: Text(
                                            "Pending Quotation List",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              value.pending_quotation_list.length > 0
                                  ? Container(
                                      height: size.height * 0.8,
                                      width: size.width,
                                      // height: value.pending_quotation_list
                                      //             .length ==
                                      //         1
                                      //     ? size.height * 0.12
                                      //     : value.pending_quotation_list
                                      //                 .length ==
                                      //             2
                                      //         ? size.height * 0.18
                                      //         : value.pending_quotation_list
                                      //                     .length ==
                                      //                 3
                                      //             ? size.height * 0.24
                                      //             : value.pending_quotation_list
                                      //                         .length ==
                                      //                     4
                                      //                 ? size.height * 0.3
                                      //                 : size.height * 0.36,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: DataTable(
                                          // dataRowHeight: rowHeight1,
                                          horizontalMargin: 10,
                                          columnSpacing: 0,
                                          // border: const TableBorder(verticalInside: BorderSide(width: 1, style: BorderStyle.solid)),
                                          headingRowHeight: 40,
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
                                          showCheckboxColumn: false,
                                          columns: [
                                            DataColumn(
                                                label: Container(
                                              width: size.width * 0.3,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'QT NO',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            DataColumn(
                                                label: Container(
                                              alignment: Alignment.centerLeft,
                                              width: size.width * 0.35,
                                              child: Text(
                                                'CUSTOMER',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            DataColumn(
                                                label: Container(
                                              width: size.width * 0.2,
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  'AGE',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ],
                                          rows: value.pending_quotation_list
                                              .map(
                                                (itemRow) => DataRow(
                                                  color: MaterialStateColor
                                                      .resolveWith((states) {
                                                    return parseColor(
                                                        itemRow["clr"]
                                                            .toString());
                                                    // return const Color.fromARGB(
                                                    //     255,
                                                    //     197,
                                                    //     196,
                                                    //     196); //make tha magic!
                                                  }),
                                                  cells: [
                                                    DataCell(
                                                      onTap: () async {
                                                        value.getStaffs(
                                                            context, "");
                                                        value.staffSelected =
                                                            "";
                                                        NextSchedulePopup next =
                                                            NextSchedulePopup();
                                                        next.buildPendingPopup(
                                                            context,
                                                            MediaQuery.of(
                                                                    context)
                                                                .size,
                                                            itemRow[
                                                                "s_invoice_id"],
                                                            "",
                                                            "quotation",
                                                            "",
                                                            "pen quot");
                                                      },
                                                      Container(
                                                          width:
                                                              size.width * 0.3,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            itemRow[
                                                                "s_invoice_no"],
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )),
                                                      placeholder: false,
                                                    ),

                                                    DataCell(
                                                      Container(
                                                          width:
                                                              size.width * 0.38,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            itemRow[
                                                                "s_customer_name"],
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )),
                                                      placeholder: false,
                                                    ),
                                                    // DataCell(
                                                    //   ConstrainedBox(
                                                    //     constraints:
                                                    //         BoxConstraints(
                                                    //             maxWidth:
                                                    //                 size.width *
                                                    //                     0.38),
                                                    //     child: Column(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .start,
                                                    //       crossAxisAlignment:
                                                    //           CrossAxisAlignment
                                                    //               .start,
                                                    //       // mainAxisSize:
                                                    //       //     MainAxisSize.max,
                                                    //       children: [
                                                    //         SizedBox(
                                                    //           height: 10,
                                                    //         ),
                                                    //         // Text(
                                                    //         //     "djfjdhnf jfjdnj jdfffffffff djfjjnjfnjd jjfjzdnjfnjd",
                                                    //         //     overflow:
                                                    //         //         TextOverflow
                                                    //         //             .ellipsis),
                                                    //         Text(
                                                    //             itemRow[
                                                    //                 "s_customer_name"],
                                                    //             overflow:
                                                    //                 TextOverflow
                                                    //                     .ellipsis),
                                                    //         // Text(
                                                    //         //   "( ${itemRow["s_invoice_no"]} ) / ${itemRow["days"]} days",
                                                    //         //   overflow:
                                                    //         //       TextOverflow
                                                    //         //           .ellipsis,
                                                    //         //   style: TextStyle(
                                                    //         //       fontSize: 13,
                                                    //         //       fontWeight:
                                                    //         //           FontWeight
                                                    //         //               .bold,
                                                    //         //       color: Colors
                                                    //         //           .grey),
                                                    //         // ),
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    //   placeholder: false,
                                                    //   // onTap: (){_getSelectedRowInfo(itemRow.itemName,itemRow.itemPrice);},
                                                    // ),
                                                    // DataCell(
                                                    //   onTap: () async {
                                                    //     value.getStaffs(
                                                    //         context,
                                                    //         itemRow[
                                                    //             "to_staff"]);
                                                    //     value.staffSelected =
                                                    //         itemRow["to_staff"];
                                                    //     NextSchedulePopup next =
                                                    //         NextSchedulePopup();
                                                    //     next.buildPendingPopup(
                                                    //         context,
                                                    //         MediaQuery.of(
                                                    //                 context)
                                                    //             .size,
                                                    //         itemRow[
                                                    //             "s_invoice_id"],
                                                    //         itemRow["enq_id"],
                                                    //         "quotation",
                                                    //         itemRow[
                                                    //             "next_date"]);
                                                    //   },
                                                    //   Container(
                                                    //     width: size.width * 0.2,
                                                    //     child: Text(
                                                    //       itemRow[
                                                    //           "prepared_by"],
                                                    //       style: TextStyle(
                                                    //           fontWeight:
                                                    //               FontWeight
                                                    //                   .bold,
                                                    //           color:
                                                    //               Colors.red),
                                                    //     ),
                                                    //   ),
                                                    //   placeholder: false,
                                                    // ),
                                                    DataCell(
                                                      Container(
                                                          width:
                                                              size.width * 0.2,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8.0),
                                                            child: Text(
                                                              itemRow["age"],
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          )),
                                                      placeholder: false,
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                  ),
                );
              },
            ),
          );
        });
  }

  Color parseColor(String color) {
    print("Colorrrrr...$color");
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }
}
