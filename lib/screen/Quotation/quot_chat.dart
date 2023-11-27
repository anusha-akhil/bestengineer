import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotChat extends StatefulWidget {
  String inv_id;
  String title;

  QuotChat({required this.inv_id, required this.title});

  @override
  State<QuotChat> createState() => _QuotChatState();
}

class _QuotChatState extends State<QuotChat> {
  TextEditingController remark = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String? user_id;
  String? today;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShared();
    Provider.of<QuotationController>(context, listen: false)
        .getQuotPreviousChat(widget.inv_id.toString(), context, "");
    today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    selecteddate = null;
  }

  String? selecteddate;
  void _showdatepicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      setState(() {
        selecteddate = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    Provider.of<QuotationController>(context, listen: false)
        .getQuotPreviousChat(widget.inv_id.toString(), context, "");
    _refreshController.refreshCompleted();
  }

  getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
                onTap: () {
                  Provider.of<QuotationController>(context, listen: false)
                      .getQuotPreviousChat(
                          widget.inv_id.toString(), context, "");
                },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
          )
        ],
        title: Row(
          children: [
            Text(
              "Remark History - ",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Flexible(
              child: Text(
                "${widget.title}",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        child: Consumer<QuotationController>(builder: (context, value, child) {
          if (value.isChatLoading) {
            return Center(
              child: SpinKitCircle(
                color: P_Settings.loginPagetheme,
              ),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            _showdatepicker();
                          },
                          child: Icon(Icons.calendar_month)),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        selecteddate == null
                            ? today.toString()
                            : selecteddate.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      )
                    ],
                  ),
                ),
                value.quotremarkChatList.length == 0
                    ? Expanded(
                        child: Container(
                            height: 200,
                            width: 180,
                            child: Lottie.asset("assets/noChat.json")))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: value.quotremarkChatList.length,
                          itemBuilder: (context, index) {
                            // String rem = value.quotserviceChatList[index]
                            //         ["remark"]
                            //     .replaceAll("\n", " ");
                            return Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: ListTile(
                                // tileColor:
                                //     value.serviceChatList[index]["USERS_ID"] == user_id
                                //         ? Color.fromARGB(255, 213, 236, 214)
                                //         : Colors.white,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      value.quotremarkChatList[index]
                                                  ["user_id"] ==
                                              user_id
                                          ? AssetImage("assets/man.png")
                                          : AssetImage("assets/man2.png"),
                                ),
                                trailing: Text(
                                  value.quotremarkChatList[index]["added_on"]
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text("djknjksfdnd fnzdfnjd f dfdfn fxd fxdfdf df dhfdhfbdf"),
                                    Text(value.quotremarkChatList[index]
                                        ["NAME"]),
                                    value.quotremarkChatList[index]
                                                    ["next_contact_date"] ==
                                                null ||
                                            value
                                                .quotremarkChatList[index]
                                                    ["next_contact_date"]
                                                .isEmpty ||
                                            value.quotremarkChatList[index]
                                                    ["next_contact_date"] ==
                                                "null"||value.quotremarkChatList[index]
                                                    ["next_contact_date"] ==
                                                " "
                                        ? Container()
                                        : Row(
                                            children: [
                                              Text(
                                                "Next Contact date:",
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 12),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  value.quotremarkChatList[
                                                          index]
                                                      ["next_contact_date"],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        // "dsdksnzd fnfffd fnf jdfjf jfnjnjfdndjfn jdfnjdfnnnnnnnj fjddddddddddd djjjjjjj",
                                        value.quotremarkChatList[index]
                                                ["remark"]
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                Container(
                  // height: 50,
                  // color: Colors.grey[100],
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                            controller: remark,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              hintText: "Enter  Remark......",
                              hintStyle: TextStyle(fontSize: 12),
                              border: InputBorder.none,

                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(8)),
                            )),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 3),
                        child: InkWell(
                          onTap: () {
                            String date;
                            if (selecteddate == null) {
                              date = "";
                            } else {
                              date = selecteddate.toString();
                            }
                            if (remark.text != null && remark.text.isNotEmpty) {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .saveQuotServiceChat(widget.inv_id, date,
                                      remark.text, context);
                              remark.clear();
                            }
                          },
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/send.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
