import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/address/controller/addresscontroller.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/address/view/addaddress.dart';

import 'addressitem.dart';

class AllAddresses extends StatefulWidget {
  @override
  _AllAddressesState createState() => _AllAddressesState();
}

class _AllAddressesState extends State<AllAddresses> {
  List addresses = [];

  Function updateState;
  Future value;

  Future getData() async {
    addresses = await AddressController.getAddress();
    return addresses;
  }

  @override
  void initState() {
    // TODO: implement initState
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
            Get.off(() => AddAddress());
            print("floating");
          },
          child: Icon(Icons.add_location),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: AutoSizeText(
            "MyAddresses",
            style: TextStyle(color: Colors.white, fontSize: 20),
            maxLines: 1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: FutureBuilder(
          builder: (context, AsyncSnapshot<dynamic> snap) {
            if (snap.data != null) {
              return ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      AddressItem(
                        city: addresses[index]['city'],
                        country: addresses[index]['country'],
                        street: addresses[index]['street'],
                        name: addresses[index]['name'],
                        nearTo: addresses[index]['nearto'],
                        id: addresses[index]['id'],
                        updateAState: updateState,
                        type: addresses[index]['type'],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                    ],
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
        ));
  }
}
