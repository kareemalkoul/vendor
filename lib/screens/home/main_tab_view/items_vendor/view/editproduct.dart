import 'dart:io';
import 'package:get/get.dart';
import 'package:vendor/main.dart';
import 'package:vendor/screens/home/main_tab_view/add_item_vendor/controller/addproductcontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/controller/productscontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/items_vendor.dart';
import 'package:vendor/screens/home/view/home.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  var name;
  var price;
  var description;
  var quantity;
  List images = [];
  var id;

  EditProduct(
      {this.name,
      this.images,
      this.description,
      this.quantity,
      this.price,
      this.id});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> with RouteAware {
  bool ishere = true;
  bool isback = true;
  var name;
  var price;
  var description;
  var quantity;
  var id;
  bool loading = false;
  List images = [];
  List productImages = [];
  List deletedImages = [];

  void init() {
    price = widget.price;
    description = widget.description;
    quantity = widget.quantity;
    name = widget.name;
    id = widget.id;
    productImages = widget.images;

    print(productImages);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    print("didpush");
    ishere = true;
    // Route was pushed onto navigator and is now topmost route.
  }

  @override
  void didPop() {
    print("didpop");

    ishere = false;
    // TODO: implement didPop
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        isback == true ? Get.back() : null;
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  isback = false;
                  if (ishere == true)
                    setState(() {
                      loading = !loading;
                    });

                  if (await ProductsController.deleteProduct(id) != false)
                    for (var item in products) {
                      if (item["id"] == id) {
                        products.remove(item);
                        break;
                      }
                      for (int i = 0; i < productImages.length; i++) {
                        await AddProductController.deleteProductImage(
                            productImages[i]);
                      }
                      // ImageUploader.

                    }

                  if (ishere == true)
                    setState(() {
                      loading = !loading;
                    });

                  try {
                    if (ishere == true) Get.back();
                  } catch (e) {
                    print("context isnt valid");
                  }
                  print(ishere);
                  isback = true;
                }),
          ],
          title: Text(
            "Edit Product",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: loading
            ? Center(
                child: SizedBox(
                  height: getHeight(200),
                  width: getWidth(200),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getHeight(90),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "$name",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            name = value;
                            print(name);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 2,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "$price",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            price = value;
                            print(price);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 2,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "$quantity",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            quantity = value;
                            print(quantity);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "$description",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            description = value;
                            print(description);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(50),
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
                                var pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {
                                  images.add(pickedImage);
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
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onLongPress: () {
                                      setState(() {
                                        images.remove(images[index]);
                                      });
                                    },
                                    child: ListImage(
                                      image: images[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: getWidth(30),
                          ),
                          Text(
                            "Product Images :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      Container(
                        height: getHeight(170),
                        width: getWidth(210),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productImages.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () {
                                setState(() {
                                  deletedImages.add(productImages[index]["id"]);
                                  productImages.remove(productImages[index]);
                                });
                              },
                              child: ListProductImage(
                                image: productImages[index]["url"],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      MyButton(
                        buttonColor: Theme.of(context).primaryColor,
                        text: "Edit",
                        textColor: Colors.white,
                        height: getHeight(50),
                        width: getWidth(200),
                        fun: () async {
                          setState(() {
                            loading = !loading;
                          });

                          var editRes = await AddProductController.editProduct(
                              name, price, description, quantity, id);

                          if (editRes) {
                            for (int i = 0; i < images.length; i++) {
                              await AddProductController.addProductImage(
                                  images[i], id);
                            }
                            for (int i = 0; i < deletedImages.length; i++) {
                              await AddProductController.deleteProductImage(
                                  deletedImages[i]);
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          }
                        },
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class ListImage extends StatelessWidget {
  final image;
  ListImage({this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: getHeight(170),
          width: getWidth(100),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(
                File(image.path),
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        SizedBox(
          width: getWidth(10),
        ),
      ],
    );
  }
}

class ListProductImage extends StatelessWidget {
  final image;
  ListProductImage({this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: getHeight(170),
          width: getWidth(100),
          decoration: BoxDecoration(
            image:
                DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        SizedBox(
          width: getWidth(10),
        ),
      ],
    );
  }
}
