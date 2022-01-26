import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:vendor/configs/adds_service.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/controller/productscontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/view/editproduct.dart';
import 'package:vendor/widgets/item_card.dart';

bool isExpanded = false;
List products = [];
List images = [];
RxBool isloading = true.obs;
Future value;

class ItemsVendor extends StatefulWidget {
  @override
  _ItemsVendorState createState() => _ItemsVendorState();
}

class _ItemsVendorState extends State<ItemsVendor> {
  Future getData() async {
    products = await ProductsController.getProducts();
    for (int i = 0; i < products.length; i++) {
      if (products[i]["Images"].length != 0)
        images.add(products[i]["Images"][0]["url"]);
      else
        images.add("");
    }
    return products;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // homeController.vinit();
    isloading.value = true;
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsServices.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    _nativeAdController.dispose();
    super.dispose();
  }

  final _nativeAdController = NativeAdmobController();

  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () async {
          products = [];
          images = [];
          await getData();
          setState(() {});
        },
        child: ListView(
          children: [
            AdmobBanner(
                adUnitId: AdsServices.bannerAdUnitId,
                adSize: AdmobBannerSize.FULL_BANNER),
            if (products.length == 0)
              Container(
                padding: EdgeInsets.all(20),
                height: constraints.maxHeight,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Center(
                    child: Column(
                      children: [
                        AutoSizeText(
                          "no product to show  it",
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          " Swap to update informations",
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ...List.generate(
                    products.length,
                    (index) => Column(
                      children: [
                        ItemCard(
                          key: Key("$index-product"),
                          // onTap: () {
                          //   if (products[index]["discount"] == 0) {
                          //     Get.to(() => Discount(
                          //           name: products[index]["name"],
                          //           price: products[index]["price"],
                          //           id: products[index]["id"],
                          //         ));
                          //   } else {
                          //     //Get.to(() => editeDiscount);
                          //   }
                          // },
                          onTap: () {
                            Get.to(
                              () => EditProduct(
                                name: products[index]["name"],
                                price: products[index]["price"],
                                description: products[index]["description"],
                                quantity: products[index]["quantity"],
                                images: products[index]["Images"],
                                id: products[index]["id"],
                              ),
                            );
                          },
                          index: index,
                          name: products[index]["name"],
                          image: images[index],
                          price: products[index]["price"].toDouble(),
                          id: products[index]["id"],
                          quantity: products[index]["quantity"],
                        ),
                        Divider(),
                      ],
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}

class HeaderOfItems extends StatefulWidget {
  @override
  _HeaderOfItemsState createState() => _HeaderOfItemsState();
}

class _HeaderOfItemsState extends State<HeaderOfItems> {
  bool _isExpanded = false;
  int items_total = 0;
  final List<int> categoryCount = [5, 6, 4, 4, 7, 8, 9, 55];
  final List<String> categoryName = ["cat1", "cat2", "cat3", "cat4", "cat5"];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          textTheme:
              TextTheme(bodyText1:  TextStyle(fontSize: 20, color: Colors.black))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 500),
          // dividerColor: Colors.black,
          expandedHeaderPadding:
              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _isExpanded,
              headerBuilder: (context, isExpanded) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    children: [
                      Text("items count total"),
                    ],
                  ),
                );
              },
              body: Column(
                children: [
                  ...List.generate(
                    categoryName.length,
                    (index) => NumberItemsCard(
                      categoryName: categoryName[index],
                      categoryCount: categoryCount[index],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  NumberItemsCard(
                    categoryName: "Total...",
                    categoryCount: items_total,
                  )
                ],
              ),
            ),
          ],
          expansionCallback: (i, b) {
            setState(() {
              _isExpanded = !b;
            });
          },
        ),
      ),
    );
  }
}

class NumberItemsCard extends StatelessWidget {
  const NumberItemsCard({
    Key key,
    @required this.categoryName,
    @required this.categoryCount,
  }) : super(key: key);

  final String categoryName;
  final int categoryCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Text(
            "${categoryName}",
            style: TextStyle(fontSize: 25),
          ),
          Spacer(),
          Text("${categoryCount}")
        ],
      ),
    );
  }
}
