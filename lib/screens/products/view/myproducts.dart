import 'package:vendor/screens/home/main_tab_view/items_vendor/view/editproduct.dart';
import 'package:vendor/screens/products/controller/productscontroller.dart';
import 'package:vendor/screens/products/view/productitem.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  List products = [];
  List images = [];

  Future value;

  Future getData() async {
    products = await ProductsController.getProducts();
    for (int i = 0; i < products.length; i++) {
      if (products[i]["Images"].length != 0)
        images.add(products[i]["Images"][0]["url"]);
      else
        images.add(
            "https://res.cloudinary.com/dfgyblmcb/image/upload/v1627842612/istockphoto-936182806-612x612-removebg-preview_nd05mz.png");
    }
    return products;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "My Products",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            backgroundColor: Colors.lightBlue,
          ),
          drawer: Container(),
          body: FutureBuilder(
            builder: (context, AsyncSnapshot<dynamic> snap) {
              if (snap.data != null) {
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        print("hi");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProduct(
                                      name: products[index]["name"],
                                      price: products[index]["price"],
                                      description: products[index]
                                          ["description"],
                                      quantity: products[index]["quantity"],
                                      images: products[index]["Images"],
                                      id: products[index]["id"],
                                    )));
                      },
                      child: Column(
                        children: [
                          ProductsItem(
                            name: products[index]["name"],
                            image: images[index],
                          ),
                          Divider(
                            color: Colors.lightBlue,
                            thickness: 1.5,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            },
            future: value,
          )),
    );
  }
}
