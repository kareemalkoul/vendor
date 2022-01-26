import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/drawer/doc/controller/documentcontroller.dart';
import 'package:vendor/screens/drawer/doc/view/add_doc.dart';
import 'package:vendor/screens/drawer/doc/view/carddoc.dart';

var doc;

class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  var value;
  Function updateState;

  Future getData() async {
    value = DocumentController.getDocument();
    doc = await value;

    return doc;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print(doc);

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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Documment"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.off(() => AddDoc());
          print("floating");
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (doc.length != 0) {
                return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          CardDocument(
                            id: doc[index]["id"],
                            title: doc[index]["name"],
                            image: doc[index]["image"],
                            updateState: updateState,
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Divider(
                            indent: 20,
                            thickness: 2,
                          )
                        ],
                      ),
                    );
                  },
                );
              }
              return Center(child: Text("no doc to show it"));
            } else
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
          },
          future: value,
        ),
      ),
    );
  }
}
