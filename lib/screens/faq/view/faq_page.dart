// import 'package:ecommerce_int2/app_properties.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/configs/size.dart';
import 'package:vendor/requests_handling/requests.dart';
import '../model/faq_model.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  List<Panel> panels = [];

  bool loading = false;
  bool error = false;
  List<FaqModel> faqs = [];

  fetchData() async {
    loading = true;
    setState(() {});
    try {
      final apiResult = await Requests.getRequest(
          "https://floating-badlands-10743.herokuapp.com/api/faq/all");
      if (apiResult.statusCode == 200) {
        faqs = faqModelFromJson(apiResult.body);

        panels.clear();
        for (int i = 0; i < faqs.length; i++) {
          panels.add(Panel(faqs[i].question, faqs[i].answer, true));
        }
      } else {
        error = true;
      }
    } catch (e) {
      print("faq:" + e.toString());
      loading = false;
      error = true;
      setState(() {});
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 34.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, bottom: 16.0),
                  child: Text(
                    'FAQ',
                    style: h5_24pt_without_color,
                  ),
                ),
                ...panels
                    .map((panel) => ExpansionTile(
                            title: Text(
                              panel.title,
                              //style: darkGrayText_14pt_bold,
                            ),
                            children: [
                              Container(
                                  width: getWidth(410),
                                  padding: EdgeInsets.all(16.0),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                  child: Text(panel.content,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)))
                            ]))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}

TextStyle h5_24pt_without_color = GoogleFonts.tajawal(
  fontSize: 24,
);
TextStyle darkGrayText_14pt_bold = GoogleFonts.tajawal(
    fontSize: 14, color: Color(0xFF707070), fontWeight: FontWeight.bold);
