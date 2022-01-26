import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';

class ProductsItem extends StatelessWidget {
  final name;
  final image;
  final id;
  ProductsItem({this.id, this.name, this.image});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: getHeight(150),
          child: Row(
            children: [
              SizedBox(
                width: getWidth(30),
              ),
              Container(
                height: getHeight(100),
                width: getWidth(100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image)),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
              SizedBox(
                width: getWidth(50),
              ),
              Text(
                "$name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          )),
      onTap: () {},
    );
  }
}
