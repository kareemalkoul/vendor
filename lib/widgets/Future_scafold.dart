import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/config_data.dart';
import 'package:vendor/configs/size.dart';

class FutureScafold extends StatelessWidget {
  final data;
  final Future Function() fetchData;
  final String nameScreen;
  final Widget child;
  final FloatingActionButton floatingActionButton;

  final Widget Function(BuildContext, int, dynamic, Function) itemBuilder;
  const FutureScafold(
      {Key key,
      this.data,
      this.fetchData,
      this.nameScreen,
      this.child,
      this.floatingActionButton,
      this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build FutureScafold ${nameScreen}");

    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        centerTitle: true,
        title: Text(nameScreen),
      ),
      body: SafeArea(
        child: MyFuture(
          fetchData: fetchData,
          nameScreen: nameScreen,
          data: data,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}

class MyFuture extends StatefulWidget {
  MyFuture({
    Key key,
    @required this.nameScreen,
    @required this.data,
    @required this.itemBuilder,
    this.fetchData,
  }) : super(key: key);

  final String nameScreen;
  var data;

  final Future Function() fetchData;
  final Widget Function(BuildContext, int, dynamic, Function) itemBuilder;

  @override
  _MyFutureState createState() => _MyFutureState();
}

class _MyFutureState extends State<MyFuture> {
  Future get() async {
    if (ConfigData.isRefreshOnBuild) {
      print("getData by ConfigData.isRefreshOnBuild");
      return await getData();
    } else if (widget.data == null) {
      print("getData by data is null");
      return await getData();
    }
  }

  Future getData() async {
    widget.data = widget.fetchData();
    return widget.data = await widget.data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build MyFuture ${widget.nameScreen}");
    return FutureBuilder(
      future: get(),
      builder: (context, snapshot) {
        print(snapshot.data);
        print(widget.data);
        print("build Future builder ${widget.nameScreen}");
        if (snapshot.data != null || !(widget.data is Future<dynamic>)) {
          return RefreshIndicator(
            onRefresh: () async {
              print("onrefresh ${widget.nameScreen} start");
              widget.data = await widget.fetchData();
              print("onrefresh ${widget.nameScreen} end");
              setState(() {});
            },
            child: (widget.data == null || widget.data.length == 0)
                ? IsEmpty(
                    name: widget.nameScreen,
                  )
                : BodyItems(
                    data: widget.data,
                    itemBuilder: (x, y, z, w) {
                      return widget.itemBuilder(x, y, z, () {
                        print("called setState ${widget.nameScreen}");
                        setState(() {
                          getData();
                        });
                      });
                    }),
          );
        } else {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: const CircularProgressIndicator(
                strokeWidth: 8,
              ),
            ),
          );
        }
      },
    );
  }
}

class BodyItems extends StatefulWidget {
  const BodyItems({
    Key key,
    @required this.data,
    @required this.itemBuilder,
  }) : super(key: key);

  final data;
  final Widget Function(
      BuildContext, int, dynamic, void Function(void Function())) itemBuilder;

  @override
  _BodyItemsState createState() => _BodyItemsState();
}

class _BodyItemsState extends State<BodyItems> {
  @override
  Widget build(BuildContext context) {
    print("build BodyItems ");
    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return widget.itemBuilder(context, index, widget.data, setState);
      },
    );
  }
}

class IsEmpty extends StatelessWidget {
  final String name;

  const IsEmpty({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.bodyHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                "No $name to show it",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              AutoSizeText(
                "please press + to add $name",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
