import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/report/controller/reportcontroller.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  var problem;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          "Support",
          style: TextStyle(color: Colors.white, fontSize: 20),
          maxLines: 1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: loading
          ? Center(
              child: SizedBox(
                height: getHeight(200),
                width: getWidth(200),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getHeight(250),
                    ),
                    SizedBox(
                      height: getHeight(50),
                      width: getWidth(340),
                      child: MyTextField(
                        type: 3,
                        borderColor: Theme.of(context).primaryColor,
                        hintText: "Problem",
                        hintTextColor: Colors.grey.shade400,
                        textColor: Theme.of(context).primaryColor,
                        valControl: (value) {
                          problem = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: getHeight(100),
                    ),
                    MyButton(
                      text: "Send feedback",
                      textColor: Colors.white,
                      buttonColor: Theme.of(context).primaryColor,
                      height: getHeight(50),
                      width: getWidth(200),
                      fun: () async {
                        setState(() {
                          loading = !loading;
                        });
                        var res = await ReportController.reportProblem(problem);
                        if (res == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("an error occurred!"),
                            backgroundColor: Theme.of(context).primaryColor,
                          ));
                        } else if (res != null) Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
