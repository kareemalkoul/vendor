import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/drawer/profile/textfield_editing_vendor.dart';
import 'package:vendor/screens/drawer/sale/controller/salecontoller.dart';
import 'package:vendor/screens/drawer/sale/view/editesale.dart';
import 'package:vendor/screens/drawer/sale/view/sales.dart';
import 'package:vendor/screens/drawer/story/controller/storycontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/controller/productscontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/items_vendor.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/view/editproduct.dart';
import 'package:vendor/widgets/item_card.dart';

class AddSales extends StatefulWidget {
  @override
  _AddSalesState createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  var selectedcat;
  var selectedbool;
  var value;
  Future getData() async {
    products = await ProductsController.getProducts();
    for (int i = 0; i < products.length; i++) {
      selectedbool.add(false);
      if (products[i]["Images"].length != 0)
        images.add(products[i]["Images"][0]["url"]);
      else
        images.add("");
    }
    setState(() {});
    return products;
  }

  @override
  void initState() {
    super.initState();
    isloading.value = true;
    value = getData();
    selectedbool = [];
    selectedcat = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Sale"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: value,
          builder: (context, snapshot) => snapshot.data != null
              ? LayoutBuilder(
                  builder: (context, constraints) => RefreshIndicator(
                    onRefresh: () async {
                      products = [];
                      images = [];
                      // setState(() {});

                      await getData();
                      setState(() {});
                    },
                    child: ListView(
                      children: [
                        if (selectedbool.length == 0)
                          Container(
                            padding: EdgeInsets.all(20),
                            height: constraints.maxHeight,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Center(
                                child: Text(
                                    "no product to show  it\nSwap to update information"),
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
                                (index) {
                                  print(products.length);
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: constraints.maxWidth,
                                            child: ItemCard(
                                              key: Key("$index-product"),
                                              index: index,
                                              name: products[index]["name"],
                                              image: images[index],
                                              price: products[index]["price"]
                                                  .toDouble(),
                                              quantity: products[index]
                                                  ["quantity"],
                                              id: products[index]["id"],
                                              onTap: () {
                                                if (products[index][
                                                            "product_discount"] ==
                                                        null ||
                                                    products[index][
                                                            "product_discount"] ==
                                                        0) {
                                                  Get.to(
                                                    () => AddSalesDetails(
                                                      ids: products[index]
                                                          ["id"],
                                                      price: products[index]
                                                          ["price"],
                                                    ),
                                                  );
                                                } else
                                                  Get.to(() => EditeSale(
                                                        id: products[index]
                                                            ["id"],
                                                        ids: products[index][
                                                                "product_discount"]
                                                            ["id"],
                                                        price: products[index][
                                                                    "product_discount"]
                                                                ["value"]
                                                            .toDouble(),
                                                      ));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                    ],
                                  );
                                },
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class AddSalesDetails extends StatefulWidget {
  final ids;
  final price;

  AddSalesDetails({Key key, this.ids, this.price}) : super(key: key);

  @override
  _AddSalesDetailsState createState() => _AddSalesDetailsState();
}

class _AddSalesDetailsState extends State<AddSalesDetails> {
  String dateEnd = "2026-8-8";
  int price;
  var image;
  var name;
  bool isAddStory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAddStory = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Sale"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(border: Border.symmetric()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("product ids : ${widget.ids}"),
                      Divider(),
                      Text("product price : ${widget.price}"),
                      Divider(),
                    ],
                  ),
                ),
                VendorRowInfoEditing(
                  textInputType: TextInputType.name,
                  title: "name",
                  onChanged: (value) {
                    name = value;

                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                VendorRowInfoEditing(
                  textInputType: TextInputType.number,
                  title: "price",
                  onChanged: (value) {
                    if (value != "") {
                      price = int.parse(value);
                    } else {
                      price = 0;
                    }

                    setState(() {});
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("end"),
                    SizedBox(
                      width: 20,
                    ),
                    MyDate(
                      dateSelected: (value) {
                        dateEnd = value;
                        print(value);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: getHeight(200),
                  child: Row(
                    children: [
                      SizedBox(
                        width: getWidth(40),
                      ),
                      InkWell(
                        onTap: () async {
                          var pickedImage = await ImagePicker().pickImage(
                              source: ImageSource.gallery, imageQuality: 25);
                          setState(() {
                            image = pickedImage;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              )),
                          width: getWidth(100.0),
                          height: getHeight(170.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                height: getHeight(30),
                              ),
                              Text(
                                "Add image",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getWidth(20),
                      ),
                      Container(
                        height: getHeight(170),
                        width: getWidth(210),
                        child: image == null
                            ? AutoSizeText("")
                            : InkWell(
                                onLongPress: () {
                                  setState(() {
                                    image = null;
                                  });
                                },
                                child: ListImage(
                                  image: image,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Text(
                        "add to story",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Checkbox(
                          value: isAddStory,
                          onChanged: (x) {
                            setState(() {
                              isAddStory = x;
                            });
                          })
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: FloatingActionButton(
          isExtended: true,
          child: Text("Submit"),
          onPressed: () async {
            if (price == 0 ||
                price == null ||
                widget.ids == null ||
                dateEnd == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text("please complete info "),
                backgroundColor: Theme.of(context).primaryColor,
              ));
              print(dateEnd);
              print(image);
              print(widget.ids);
              print(price);
              return;
            }
            if (price > widget.price) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text("cannot discount be more than price "),
                backgroundColor: Theme.of(context).primaryColor,
              ));
              return;
            }
            print("ids");
            print(widget.ids);
            var body = await SaleController.addSale(name, widget.ids, price,
                dateEnd, DateTime.now().hour, DateTime.now().minute);
            if (isAddStory) {
              if (image == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("add image "),
                  backgroundColor: Theme.of(context).primaryColor,
                ));
                return;
              }
              DateTime now = new DateTime.now();
              DateTime date = new DateTime(
                  now.year, now.month, now.day, now.hour, now.minute);
              var day = date.day;
              var month = date.month;
              var year = date.year;
              var hour = date.hour;
              var minutes = date.minute;
              var storyId = await StoryController.addStory(
                  name, day, month, year, hour, minutes);
              if (storyId != null) {
                await StoryController.addStoryImage(image, storyId);
              }
            }

            Get.off(() => Sales());
          },
        ),
      ),
    );
  }
}

class MyDate extends StatefulWidget {
  final void Function(String) dateSelected;
  MyDate({Key key, this.dateSelected}) : super(key: key);

  @override
  _MyDateState createState() => _MyDateState();
}

class _MyDateState extends State<MyDate> {
  DateTime selectedDate = new DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    widget.dateSelected(
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () => _selectDate(context),
        child: Text(
            '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
      ),
    );
  }
}
