import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendor/configs/adds_service.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/models/models_kareem/vendor_info.dart';
import 'package:vendor/widgets/card_vendor.dart';
import 'package:vendor/widgets/chart_bar.dart';

import '../../../../configs/size.dart';

var sales = "";

var money = "";
var listEraning;

class Vendor_Details_view extends StatefulWidget {
  @override
  _Vendor_Details_viewState createState() => _Vendor_Details_viewState();
}

class _Vendor_Details_viewState extends State<Vendor_Details_view> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: FutureBuilder(builder: (context, snapshot) {
        if (listEraning != null) {
          return SingleChildScrollView(
            key: PageStorageKey<String>('Vendor'),
            physics: BouncingScrollPhysics(),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    //height: 70,
                    child: ListTile(
                      title: Text(
                        "${vendor.value.name.value}",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      subtitle: Text(
                        "Store Name",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     "Vendor Details",
                  //     style: TextStyle(fontSize: 25),
                  //   ),
                  // ),
                  CardVendor(
                    child: WeaklyDetails(
                      listEraning: listEraning,
                      total: double.parse(money),
                    ),
                  ),
                  SizedBox(height: getHeight(15),),
                  AdmobBanner(adUnitId: AdsServices.bannerAdUnitId, adSize: AdmobBannerSize.FULL_BANNER)
                  ,
                  SizedBox(height: getHeight(15),),
                  CardVendor(
                    child: Row(
                      children: [
                        Text(
                          "Total Orders",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          sales,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  CardVendor(
                    child: Row(
                      children: [
                        Text(
                          "Total Earnings",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          money,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),

                  // ListTile(
                  //   title: Text(
                  //     "Address",
                  //     style: TextStyle(
                  //       fontSize: 25,
                  //     ),
                  //   ),
                  //   subtitle: Text(
                  //     "hi",
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Review",
                  //     style: TextStyle(
                  //       fontSize: 25,
                  //     ),
                  //   ),
                  //   subtitle: Text(
                  //     "hi",
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
    );
  }
}

class WeaklyDetails extends StatefulWidget {
  final double total;
  final listEraning;

  const WeaklyDetails({Key key, this.total, this.listEraning})
      : super(key: key);
  @override
  _WeaklyDetailsState createState() => _WeaklyDetailsState();
}

class _WeaklyDetailsState extends State<WeaklyDetails> {
  var mouth1;
  var day1;
  var year1;
  var mount2;
  var day2;
  var year2;
  var dayname2;
  var dayname1;

  @override
  void initState() {
    super.initState();
    var dateToday = DateTime.now();
    mouth1 = DateFormat('MMMM').format(dateToday);
    day1 = dateToday.day;
    year1 = dateToday.year;
    dayname1 = DateFormat('EEEE').format(dateToday);
    var date7Before = DateTime.now().subtract(Duration(days: 6));
    mount2 = DateFormat('MMMM').format(date7Before);
    day2 = date7Before.day;
    year2 = date7Before.year;
    dayname2 = DateFormat('EEEE').format(date7Before);

    // getData();
  }

  // Future getData() async {
  //   listEraning = await HomeController.getWeakly();
  //   print(listEraning);
  //   setState(() {});
  //   return listEraning;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "Orders Report",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "Weakly sales report",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "$day2 $mount2  $year2 - $day1 $mouth1 $year1 ",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Row(
          children: [
            ...List.generate(
              7,
              (index) => Expanded(
                child: Container(
                  height: getHeight(240),
                  child: ChartBar(
                    label:
                        " ${DateFormat('E').format(DateTime.now().add(Duration(days: index)))}",
                    spendingPctOfTotal: widget.total != 0
                        ? (widget.listEraning[index] / widget.total)
                        : 0,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
