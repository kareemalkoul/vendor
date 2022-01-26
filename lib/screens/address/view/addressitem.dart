import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';

import 'address.dart';

class AddressItem extends StatelessWidget {
  final city;
  final country;
  final street;
  final nearTo;
  final name;
  final id;
  final type;
  final updateAState;
  AddressItem(
      {this.type,this.nearTo,
        this.name,
        this.street,
        this.country,
        this.city,
        this.id,
        this.updateAState});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: getHeight(430),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(20),
            ),
            Container(
              height: getHeight(50),
              width: getWidth(300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "name " + " :",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "$name",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            Container(
              height: getHeight(50),
              width: getWidth(300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "country"+ " :",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "$country",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            Container(
              height: getHeight(50),
              width: getWidth(300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "city"+" :",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "$city",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            Container(height: getHeight(50),
              width: getWidth(300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "street"+" :",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "$street",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            Container(height: getHeight(50),
              width: getWidth(300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "Type :",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "$type",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            Container(height: getHeight(50),
              width: getWidth(300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "near to "+" :",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: getWidth(20),
                  ),
                  AutoSizeText(
                    "$nearTo",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Address(
                  city: city,
                  street: street,
                  country: country,
                  nearTo: nearTo,
                  name: name,
                  id: id,
                  updateState: updateAState,
                )));
      },
    );
  }
}
