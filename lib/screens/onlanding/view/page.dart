import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'onlanding.dart';

class MyPage extends StatelessWidget {
  final String pathAnimation;
  final String title;
  final String descraption;

  const MyPage({Key key, this.pathAnimation, this.title, this.descraption})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("build  animo");
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Lottie.asset(
              pathAnimation,
              repeat: false,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Divider(
                  indent: width / 5,
                  endIndent: width / 5,
                  thickness: 1,
                  color: primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  child: AutoSizeText(
                    descraption,
                    style: GoogleFonts.lato(fontSize: 25, height: 1.3),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
