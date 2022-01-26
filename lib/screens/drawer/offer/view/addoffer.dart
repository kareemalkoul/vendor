import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/drawer/offer/contoller/offercontoller.dart';
import 'package:vendor/screens/drawer/offer/view/offers.dart';
import 'package:vendor/screens/drawer/profile/textfield_editing_vendor.dart';
import 'package:vendor/screens/drawer/story/controller/storycontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/controller/productscontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/items_vendor.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/view/editproduct.dart';
import 'package:vendor/widgets/item_card.dart';

class AddOffer extends StatefulWidget {
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  var selectedcat;
  var selectedbool;
  var value;
  var totalprice = 0;
  var listnum = [];
  Future getData() async {
    products = await ProductsController.getProducts();
    for (int i = 0; i < products.length; i++) {
      selectedbool.add(false);
      listnum.add(0);
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
      bottomNavigationBar: FloatingActionButton(
        isExtended: true,
        child: FittedBox(fit: BoxFit.fitHeight, child: Text("next ")),
        onPressed: () {
          if (selectedcat.length == 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text("please selected at leaste one product"),
              backgroundColor: Theme.of(context).primaryColor,
            ));
            return;
          }

          Get.to(() => AddOfferDetails(
                ids: selectedcat,
                totalprice: totalprice,
              ));
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add offer"),
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
                                      Column(
                                        children: [
                                          Container(
                                            // width: constraints.maxWidth * 0.8,
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
                                            ),
                                          ),
                                          MyAddWidget(
                                            num: listnum[index],
                                            onAdd: (num) {
                                              print(
                                                  products[index]["quantity"]);
                                              print(num);

                                              if (products[index]["quantity"] >
                                                      num ||
                                                  num < 1) {
                                                print("onadd");
                                                selectedcat
                                                    .add(products[index]["id"]);
                                                totalprice +=
                                                    products[index]["price"];
                                                return true;
                                              }
                                              print(selectedcat);

                                              return false;
                                            },
                                            onRemove: (num) {
                                              print(
                                                  products[index]["quantity"]);
                                              print(num);
                                              if (num > 0) {
                                                print("onremove");

                                                selectedcat.remove(
                                                    products[index]["id"]);
                                                totalprice -=
                                                    products[index]["price"];
                                                return true;
                                              }

                                              print(selectedcat);
                                              return false;
                                            },
                                          ),
                                          // Checkbox(
                                          //   value: selectedbool[index],
                                          //   onChanged: (x) {
                                          //     selectedbool[index] = x;
                                          //     setState(() {});
                                          //     if (x)
                                          //       selectedcat
                                          //           .add(products[index]["id"]);
                                          //     else
                                          //       selectedcat.remove(
                                          //           products[index]["id"]);

                                          //     print(selectedcat);
                                          //   },
                                          // ),
                                        ],
                                      ),
                                      Divider(
                                        indent: 18,
                                        endIndent: 18,
                                        thickness: 3,
                                        color: Theme.of(context).primaryColor,
                                      ),
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

class MyAddWidget extends StatefulWidget {
  final Function onAdd;
  final Function onRemove;
  int num;
  MyAddWidget({Key key, this.onAdd, this.onRemove, this.num = 0})
      : super(key: key);

  @override
  _MyAddWidgetState createState() => _MyAddWidgetState();
}

class _MyAddWidgetState extends State<MyAddWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              size: getWidth(35),
            ),
            onPressed: () {
              if (widget.onRemove(widget.num)) widget.num--;

              setState(() {});
            },
          ),
          SizedBox(
            width: getWidth(8),
          ),
          Text(
            "${widget.num}",
            style: TextStyle(
                fontSize: 20,
                color: widget.num == 0 ? Colors.red : Colors.green),
          ),
          SizedBox(
            width: getWidth(8),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              size: getWidth(35),
            ),
            onPressed: () {
              if (widget.onAdd(widget.num)) widget.num++;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

class AddOfferDetails extends StatefulWidget {
  final totalprice;
  final ids;

  AddOfferDetails({Key key, this.ids, this.totalprice}) : super(key: key);

  @override
  _AddOfferDetailsState createState() => _AddOfferDetailsState();
}

class _AddOfferDetailsState extends State<AddOfferDetails> {
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
        title: Text("Offer"),
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
                      Text("products ids  ${widget.ids}"),
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
        // padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          isExtended: true,
          child: Text("Submit"),
          onPressed: () async {
            // print(discounteValue);
            // if (dateBegin == null) {
            //   var date = DateTime.now();
            //   dateBegin = "{${date.year}-${date.month}-${date.day}}";
            // }
            // var kemo = await ProductsController.addDicount(
            //     widget.id,
            //     price,
            //     dateBegin,
            //     dateEnd,
            //     DateTime.now().hour,
            //     DateTime.now().minute);
            if (price == 0 ||
                price == null ||
                widget.ids.length == 0 ||
                image == null ||
                dateEnd == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text("please complete info "),
                backgroundColor: Theme.of(context).primaryColor,
              ));
              print(dateEnd);
              print(image);
              print(widget.ids.length);
              print(price);
              return;
            }
            if (widget.totalprice < price) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text("price offer uncredible !! "),
                backgroundColor: Theme.of(context).primaryColor,
              ));
              return;
            }

            print("ids");
            print(widget.ids);
            var body = await OfferController.addOffer(image, name, widget.ids,
                price, dateEnd, DateTime.now().hour, DateTime.now().minute);
            if (isAddStory) {
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

            Get.off(() => Offer());
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
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey[400])),
        onPressed: () => _selectDate(context),
        child: Text(
            '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
      ),
    );
  }
}
