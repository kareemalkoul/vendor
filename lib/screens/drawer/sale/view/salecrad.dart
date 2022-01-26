import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/drawer/sale/controller/salecontoller.dart';

class SaleCard extends StatelessWidget {
  final title;
  final image;
  final id;
  Function updateState;
  SaleCard({this.id, this.title, this.image, this.updateState});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(200),
      child: Column(
        children: [
          SizedBox(
            height: getHeight(20),
          ),
          Row(
            children: [
              SizedBox(
                width: getWidth(30),
              ),
              Container(
                child: image != "" && image != null
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      )
                    : Image.asset("assets/images/no_image_available.png"),
                height: getHeight(100),
                width: getWidth(100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
              SizedBox(
                width: getWidth(50),
              ),
              Text(
                "$title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
          SizedBox(
            height: getHeight(20),
          ),
          Row(
            children: [
              SizedBox(
                width: getWidth(330),
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    var res = await SaleController.saleDelete(id);
                    print(id);
                    if (res == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("error"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    }
                    updateState();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
