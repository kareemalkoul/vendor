import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/view/editproduct.dart';
import 'package:vendor/screens/home/main_tab_view/add_item_vendor/controller/addproductcontroller.dart';
import 'package:vendor/screens/home/view/home.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';

class EditItem extends StatefulWidget {
  String name;
  String description;
  int price;
  int quantity;
  int id;
  List images = [];

  EditItem(
      {Key key,
      this.name,
      this.description,
      this.price,
      this.quantity,
      this.id,
      this.images})
      : super(key: key);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  List images = [];
  List productImages = [];
  List deletedImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productImages = widget.images;
    print(productImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Product",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: getHeight(90),
          ),
          SizedBox(
            width: getWidth(340),
            child: MyTextField(
              type: 3,
              borderColor: Theme.of(context).primaryColor,
              hintText: "${widget.name}",
              hintTextColor: Colors.grey.shade400,
              textColor: Theme.of(context).primaryColor,
              valControl: (value) {
                widget.name = value;
                print(widget.name);
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
              hintText: "${widget.price}",
              hintTextColor: Colors.grey.shade400,
              textColor: Theme.of(context).primaryColor,
              valControl: (value) {
                widget.price = value;
                print(widget.price);
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
              hintText: "${widget.quantity}",
              hintTextColor: Colors.grey.shade400,
              textColor: Theme.of(context).primaryColor,
              valControl: (value) {
                widget.quantity = value;
                print(widget.quantity);
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
              hintText: "${widget.description}",
              hintTextColor: Colors.grey.shade400,
              textColor: Theme.of(context).primaryColor,
              valControl: (value) {
                widget.description = value;
                print(widget.description);
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
                      widget.images.add(pickedImage);
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
              var editRes = await AddProductController.editProduct(widget.name,
                  widget.price, widget.description, widget.quantity, widget.id);

              if (editRes) {
                for (int i = 0; i < widget.images.length; i++) {
                  await AddProductController.addProductImage(
                      widget.images[i], widget.id);
                }
                for (int i = 0; i < deletedImages.length; i++) {
                  await AddProductController.deleteProductImage(
                      deletedImages[i]);
                }

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              }
            },
          ),
          SizedBox(
            height: getHeight(50),
          ),
        ],
      ),
    );
  }
}
