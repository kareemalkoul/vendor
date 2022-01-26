import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';

class ItemCard extends StatelessWidget {
  final int index;
  final String name;
  final image;
  final int id;
  final double price;
  final int quantity;
  final Function onLongPress;
  final Function onTap;
  final Function onDoubleTap;

  const ItemCard(
      {Key key,
      this.index,
      this.name,
      this.image,
      this.id,
      this.price,
      this.onLongPress,
      this.onTap,
      this.onDoubleTap,
      this.quantity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onDoubleTap: onDoubleTap,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "$name",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        overflow: TextOverflow.clip,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "id: $id\n",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            TextSpan(
                              text: "${price.floor()} Usd\n",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            TextSpan(
                              text: "$quantity pieces",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: getWidth(100),
                  width: getWidth(100),
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: NetworkImage(image),
                      // ),
                      borderRadius: BorderRadius.circular(12)),
                  // child: FadeInImage.assetNetwork(
                  //   fit: BoxFit.cover,
                  //   image: image,
                  //   placeholder: "assets/images/no_image_available.png",
                  // ),
                  child: image != ""
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.white,
                          child: Image.asset(
                            "images/logo.png",
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
