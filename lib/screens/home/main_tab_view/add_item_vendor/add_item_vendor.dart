import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/drawer/doc/view/document.dart';
import 'package:vendor/screens/home/main_tab_view/add_item_vendor/controller/addproductcontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/controller/productscontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/items_vendor.dart';

class AddItemsVendor extends StatefulWidget {
  @override
  _AddItemsVendorState createState() => _AddItemsVendorState();
}

class _AddItemsVendorState extends State<AddItemsVendor> {
  TextEditingController controller;
  TextEditingController controller1;
  TextEditingController controller2;
  TextEditingController controller3;
  TextEditingController controller4;
  FocusNode foucsNode;
  List _image = [];
  final picker = ImagePicker();
  String _chosenValue;
  String _chosenValueMoney = "Usd";
  RxString name = "".obs;
  RxString description = "".obs;
  RxDouble _price = 0.0.obs;
  RxInt _quantity = 0.obs;
  var category;
  Future getImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  var _formKey;
  @override
  void initState() {
    controller = TextEditingController();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    foucsNode = FocusNode();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build add");
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      key: PageStorageKey<String>("add"),
      physics: BouncingScrollPhysics(),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      // alignment: Alignment.centerLeft,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: FittedBox(
                        child: Text("Add new item to yours"),
                      ),
                      height: getHeight(30),
                    ),
                    Divider(indent: 5, endIndent: 5),
                    //productname
                    Container(
                      height: getHeight(70),
                      // width: width / 2,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: controller3,
                        // focusNode: foucsNode,

                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.all(10),
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          //   borderSide: BorderSide(color: Colors.white, width: 1),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          //   borderSide: BorderSide(color: Colors.blue, width: 2),
                          // ),
                          // counter: null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          labelText: "NameProduct",
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.grey),
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.grey),
                        ),
                        onChanged: (value) {
                          print(value);
                          if (value != "")
                            name.value = value.toString();
                          else
                            name.value = "";

                          //controller3.text = value;
                        },
                      ),
                    ),
                    Divider(),
                    //descraption
                    Container(
                      height: getHeight(70),
                      child: TextFormField(
                        controller: controller4,
                        // focusNode: foucsNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.all(10),
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          //   borderSide: BorderSide(color: Colors.white, width: 1),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          //   borderSide: BorderSide(color: Colors.blue, width: 2),
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          labelText: "descraption",
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.grey),
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.grey),
                        ),
                        onChanged: (value) {
                          description.value = value;
                        },
                      ),
                    ),
                    Divider(),
                    //category_type
                    // Container(
                    //   height: 70,
                    //   child: TextField(
                    //     //controller: controller,
                    //     // focusNode: foucsNode,
                    //     textInputAction: TextInputAction.search,
                    //     keyboardType: TextInputType.number,
                    //     decoration: InputDecoration(
                    //       // contentPadding: EdgeInsets.all(10),
                    //       // enabledBorder: OutlineInputBorder(
                    //       //   borderRadius: BorderRadius.circular(15),
                    //       //   borderSide: BorderSide(color: Colors.white, width: 1),
                    //       // ),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: BorderSide(color: Colors.white, width: 1),
                    //       ),
                    //       labelText: "category_type",
                    //       labelStyle: TextStyle(
                    //           fontWeight: FontWeight.w300, color: Colors.grey),
                    //       hintStyle: TextStyle(
                    //           fontWeight: FontWeight.w300, color: Colors.grey),
                    //     ),
                    //   ),
                    // ),

                    //price
                    Row(
                      children: [
                        Container(
                          height: getHeight(70),
                          width: width / 2,
                          child: TextFormField(
                            validator: (value) {
                              double d;
                              try {
                                d = double.parse(value);
                              } catch (e) {
                                print(e);
                              }
                              if (d == null || d == 0) {
                                return 'Please enter number';
                              }
                              return null;
                            },
                            //controller: controller,
                            // focusNode: foucsNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            controller: controller1,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DropdownButton<String>(
                                  focusColor: Colors.white,
                                  value: _chosenValueMoney,
                                  //elevation: 5,
                                  style: TextStyle(color: Colors.white),
                                  iconEnabledColor: Colors.black,
                                  items: <String>[
                                    'Usd',
                                    'Eur',
                                    'sp',
                                    'Aed',
                                    'Gbp',
                                    'Egp',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    print(value);
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Usd",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onChanged: (String value) {
                                    _chosenValueMoney = value;
                                  },
                                ),
                              ),
                              counterText: "",
                              // suffixText: "p.s",
                              // contentPadding: EdgeInsets.all(10),

                              // enabledBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              //   borderSide: BorderSide(color: Colors.white, width: 1),
                              // ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              labelText: "price",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                            ),
                            maxLength: 6,

                            onChanged: (value) {
                              if (value != "")
                                _price.value = double.parse(value);
                              else
                                _price.value = 0;
                            },
                          ),
                        ),
                        // Expanded(
                        //   child: SliderTheme(
                        //     data: SliderThemeData(
                        //       showValueIndicator: ShowValueIndicator.always,
                        //       activeTrackColor: Theme.of(context).primaryColor,
                        //       inactiveTrackColor:
                        //           Theme.of(context).primaryColor.withOpacity(0.3),
                        //       thumbColor: Theme.of(context).primaryColor,
                        //     ),
                        //     child: Obx(
                        //       () => Slider(
                        //         divisions: 99999,
                        //         min: 0,
                        //         max: 99999,
                        //         value: _price.value,
                        //         onChanged: (x) {
                        //           _price.value = x.round().toDouble();
                        //           controller1.text = _price.value.toInt().toString();
                        //           print(_price.value);
                        //         },
                        //         label: "${_price.value}",
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Divider(),
                    //Quantity
                    Row(
                      children: [
                        Container(
                          height: getHeight(70),
                          width: width / 2,
                          child: TextFormField(
                            validator: (value) {
                              double d;
                              try {
                                d = double.parse(value);
                              } catch (e) {
                                print(e);
                              }
                              if (d == null || d == 0) {
                                return 'Please enter number';
                              }
                              return null;
                            },
                            maxLength: 3,
                            controller: controller2,
                            // focusNode: foucsNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              counterText: "",
                              //suffixText: "p.s",
                              // contentPadding: EdgeInsets.all(10),

                              // enabledBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              //   borderSide: BorderSide(color: Colors.white, width: 1),
                              // ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              labelText: "Quantity",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                            ),
                            onChanged: (value) {
                              if (value != "")
                                _quantity.value = int.parse(value);
                              else
                                _quantity.value = 0;
                            },
                          ),
                        ),

                        // Expanded(
                        //   child: SliderTheme(
                        //     data: SliderThemeData(
                        //       showValueIndicator: ShowValueIndicator.always,
                        //       activeTrackColor: Theme.of(context).primaryColor,
                        //       inactiveTrackColor:
                        //           Theme.of(context).primaryColor.withOpacity(0.3),
                        //       thumbColor: Theme.of(context).primaryColor,
                        //     ),
                        //     child: Obx(
                        //       () => Slider(
                        //         divisions: 99,
                        //         min: 0,
                        //         max: 99,
                        //         value: _quantity.value.toDouble(),
                        //         onChanged: (x) {
                        //           _quantity.value = x.round().toInt();
                        //           controller2.text = _quantity.value.toString();
                        //           print(_quantity.value);
                        //         },
                        //         label: "${_quantity.value}",
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Divider(),
                    //images
                    //ImagePicker(),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   child: DropdownButton<String>(
                    //     value: _chosenValue,
                    //     //elevation: 5,
                    //     style: TextStyle(color: Colors.black),

                    //     items: <String>[
                    //       'cat1',
                    //       'cat2',
                    //       'cat3',
                    //       'cat4',
                    //       'cat5',
                    //       'cat6',
                    //       'cat7',
                    //     ].map<DropdownMenuItem<String>>(
                    //       (String value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(value),
                    //         );
                    //       },
                    //     ).toList(),
                    //     hint: Text(
                    //       " choose a Category",
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //     onChanged: (String value) {
                    //       setState(
                    //         () {
                    //           _chosenValue = value;
                    //         },
                    //       );
                    //     },
                    //   ),
                    // ),
                    CatList(fun: (value) {
                      category = value;
                      print(category);
                    }),
                  ],
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) => Container(
                  height: width,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child:
                      // _image.isEmpty == true
                      //     ? Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           Expanded(
                      //             child: Text(
                      //               'No image selected',
                      //               style: TextStyle(fontSize: 25),
                      //             ),
                      //           ),
                      //           IconButton(
                      //             hoverColor: Colors.grey,
                      //             iconSize: 30,
                      //             color: Colors.blue,
                      //             icon: Icon(Icons.add),
                      //             onPressed: () {
                      //               getImage();
                      //             },
                      //           ),
                      //         ],
                      //       )
                      //     :

                      ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: getWidth(20),
                      ),
                      ...List.generate(
                        _image.length,
                        (index) => Stack(
                          // fit: StackFit.passthrough,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              height: width,
                              width: width - getWidth(60),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(_image[index])),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.clear,
                                  // size: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  _image.removeAt(index);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        height: width,
                        width: width - getWidth(60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add Image",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                            IconButton(
                              hoverColor: Colors.grey,
                              iconSize: 30,
                              color: Theme.of(context).primaryColor,
                              icon: Icon(Icons.add),
                              onPressed: () {
                                getImage();
                              },
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                width: width,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text("Sumbit"),
                  isExtended: true,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      print(doc);
                      if (doc == null || doc.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("please add document for verify"),
                          backgroundColor: Colors.lightBlue,
                        ));
                        return;
                      }
                      if (category == null || category.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("please select one categroy at leaste"),
                          backgroundColor: Colors.lightBlue,
                        ));
                        return;
                      }
                      if (_image == null || _image.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("please add one image at leaste "),
                          backgroundColor: Colors.lightBlue,
                        ));
                        return;
                      }
                      print("validate");

                      var productId = await AddProductController.addProduct(
                          name.value,
                          getMoneyInUsd(_chosenValueMoney, _price.value)
                              .floorToDouble(),
                          description.value,
                          _quantity.value,
                          category);
                      if (productId != null) {
                        print(productId);
                        for (int i = 0; i < _image.length; i++) {
                          await AddProductController.addProductImage(
                              _image[i], productId);
                        }

                        var checkRes =
                            productId == null ? "not succeded" : "succeded";
                        //     AddProductController.check(name, _price, _quantity);
                        // print(checkRes);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$checkRes"),
                          backgroundColor: Colors.lightBlue,
                        ));
                        products = [];
                        images = [];
                        await getData();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  double getMoneyInUsd(String country, double price) {
    double value;
    switch (country) {
      case 'Usd':
        value = 1;
        break;
      case 'Eur':
        value = 0.85;
        break;

      case 'sp':
        value = 3400;
        break;

      case 'Aed':
        value = 3.67;
        break;

      case 'Gbp':
        value = 0.73;
        break;

      case 'Egp':
        value = 15.7;
        break;
    }
    print("country $country");
    print("value $value");

    double priceInUsd = price / value;

    return priceInUsd;
  }
}

class CatList extends StatefulWidget {
  final void Function(dynamic) fun;

  const CatList({Key key, this.fun}) : super(key: key);
  @override
  _CatListState createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  bool _isExpanded = false;
  int items_total = 0;
  final List<int> categoryidSelected = [];

  final List<bool> categorySelected = [];

  //List<dynamic> categoryName = [];
  Future getCat() async {
    var body = await AddProductController.getCat();

    for (int i = 0; i < body.length; i++) {
      categoryName.add(body[i]["title"]);
      categoryid.add(body[i]["id"]);
      categorySelected.add(false);
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryName.clear();
    categoryid.clear();
    getCat();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          textTheme:
              TextTheme(bodyText1: TextStyle(fontSize: 20, color: Colors.black))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 500),
          // dividerColor: Colors.black,
          expandedHeaderPadding: EdgeInsets.symmetric(vertical: 5),
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _isExpanded,
              headerBuilder: (context, isExpanded) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    children: [
                      Text("items Selected"),
                    ],
                  ),
                );
              },
              body: Column(
                children: [
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ...List.generate(
                    categoryName.length,
                    (index) => CatSelected(
                      fun: (b) {
                        categorySelected[index] = b;
                        if (b) {
                          categoryidSelected.add(categoryid[index]);
                        } else {
                          categoryidSelected.remove(categoryid[index]);
                        }
                        widget.fun(categoryidSelected);
                      },
                      categoryName: categoryName[index],
                      isSelected: categorySelected[index],
                    ),
                  ),
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

class CatSelected extends StatelessWidget {
  CatSelected({
    @required this.categoryName,
    @required this.isSelected,
    this.fun,
  });

  final String categoryName;
  bool isSelected;
  final void Function(bool) fun;

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
          StatefulBuilder(
            builder: (context, setState) => Checkbox(
              // checkColor: Colors.green,
              //  focusColor: Colors.green,
              //hoverColor: Colors.green,
              activeColor: Theme.of(context).primaryColor,
              value: isSelected,
              onChanged: (i) {
                setState(() {
                  isSelected = i;
                });
                fun(i);
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<dynamic> categoryName = [];
List<int> categoryid = [];
