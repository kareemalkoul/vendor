import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/models/models_kareem/cupon__sale_icons.dart';
import 'package:vendor/screens/drawer/sale/controller/salecontoller.dart';
import 'package:vendor/screens/drawer/sale/view/addsale.dart';
import 'package:vendor/screens/drawer/sale/view/editesale.dart';
import 'package:vendor/screens/drawer/sale/view/salecrad.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/items_vendor.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  Future value;
  List sales = [];
  Function updateState;

  @override
  void initState() {
    super.initState();
    value = getData();
    updateState = () {
      print("called");
      setState(() {
        value = null;
        value = getData();
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Get.off(() => AddSales());
          },
          child: Icon(
            Icons.add,
          )),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          "Sales",
          style: TextStyle(color: Colors.white, fontSize: 20),
          maxLines: 1,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<dynamic> snap) {
            if (snap.data != null) {
              return RefreshIndicator(
                onRefresh: () async {
                  await getData();
                  setState(() {});
                },
                child: ListView(
                  children: [
                    if (sales.length != 0)
                      Column(
                        children: [
                          ...List.generate(sales.length, (index) {
                            var imageproduct;
                            for (var map in products) {
                              if (map.containsKey("product_id")) {
                                if (map["product_id"] ==
                                    sales[index]["product_id"]) {
                                  imageproduct =
                                      map["product_id"]["Images"][0]["url"];
                                  // your list of map contains key "id" which has value 3

                                }
                              }
                            }
                            return InkWell(
                              onTap: () {
                                Get.to(() => EditeSale(
                                      id: sales[index]["id"],
                                      ids: sales[index]["product_id"],
                                      price: sales[index]["value"].toDouble(),
                                    ));
                              },
                              child: Column(
                                children: [
                                  SaleCard(
                                    id: sales[index]["id"],
                                    title: sales[index]["id"],
                                    image: imageproduct,
                                    updateState: updateState,
                                  ),
                                  Divider(
                                    color: Theme.of(context).primaryColor,
                                    thickness: 1.5,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      )
                    else
                      SizedBox(
                          height: SizeConfig.screenHeight -
                              AppBar().preferredSize.height,
                          child: Center(child: Text("no sales to show it"))),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          },
          future: value,
        ),
      ),
    );
  }

  Future getData() async {
    sales = await SaleController.getSales();
    return sales;
  }
}
