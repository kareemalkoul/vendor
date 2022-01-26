import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/drawer/profile/editing_profile.dart';

class ProfilePicture extends StatefulWidget {
  final bool isEdite;
  final String image;
  String seconedimage;
  final bool isfirst;

  final onTap;
  ProfilePicture(
      {@required this.image,
      this.isEdite,
      this.onTap,
      this.seconedimage = "assets/images/profile.png",
      this.isfirst = true});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    print(widget.isfirst);

    double width = MediaQuery.of(context).size.width;
    double width1 = width * 0.5;
    return Center(
      child: SizedBox(
        width: width1,
        height: width1,
        child: Stack(
          children: [
            InkWell(
              onTap: !widget.isEdite
                  ? () async {
                      widget.seconedimage = await widget.onTap();
                      print(widget.isfirst);
                      setState(() {});
                    }
                  : null,
              child: SizedBox(
                height: width1,
                width: width1,
                child: CircleAvatar(
                  backgroundImage: (widget.image != "" && widget.isfirst)
                      ? NetworkImage(widget.image)
                      : widget.isfirst
                          ? AssetImage(widget.seconedimage)
                          : FileImage(File(widget.seconedimage)),
                  // widget.image != null
                  //     ? SizedBox(
                  //         height: width1, width: width1, child: widget.image)
                  //     : Image.asset(
                  //         "assets/images/profile.png",
                  //       ),
                ),
              ),
            ),
            if (widget.isEdite)
              Positioned(
                top: width1 * 0.707,
                right: width1 * .0707,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      //borderRadius: BorderRadius.circular(500),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4)),
                  child: SizedBox(
                    width: width1 / 5,
                    height: width1 / 5,
                    child: IconButton(
                      icon: FittedBox(
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: width,
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => EditingProfile());
                      },
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
