import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Set<String> searchHistory;
  String searchWord;
  final textFieldController;

  SearchBar(this.searchHistory, this.searchWord, this.textFieldController);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    FocusNode foucsNode = FocusNode();

    return Container(
      height: height * 4 / 64,
      // color: kprimary,
      child: Row(
        children: [
          Container(
            width: width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 30,
                textInputAction: TextInputAction.search,
                buildCounter: (BuildContext context,
                        {int currentLength, int maxLength, bool isFocused}) =>
                    null,
                controller: widget.textFieldController,
                autofocus: false,
                focusNode: foucsNode,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  // fillColor: Colors.amber,
                  // filled: true,
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.white),
                ),
                onEditingComplete: () {
                  print("ok");
                  String text = widget.textFieldController.text;
                  widget.searchWord = text;
                  widget.searchHistory.add(text);
                  widget.textFieldController.clear();
                  setState(() {});
                  foucsNode.requestFocus();
                  foucsNode.unfocus();
                },
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                // color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                color: Colors.white,
                icon: Icon(
                  widget.textFieldController.text.length == 0
                      ? Icons.search
                      : Icons.clear,
                ),
                onPressed: () {
                  if (widget.textFieldController.text.length == 0) {
                    if (FocusScope.of(context).hasFocus)
                      FocusScope.of(context).requestFocus(foucsNode);
                  } else {
                    if (FocusScope.of(context).hasFocus) {
                      widget.textFieldController.clear();
                      setState(() {});
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar2 extends StatefulWidget {
  final Set<String> searchHistory;
  String searchWord;
  final textFieldController;

  SearchBar2(this.searchHistory, this.searchWord, this.textFieldController);

  @override
  _SearchBar2State createState() => _SearchBar2State();
}

class _SearchBar2State extends State<SearchBar2>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    FocusNode foucsNode = FocusNode();
    print(height.toString() + 'kemo'.toString());

    return Container(
      height: height * 15 / 64,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              height = constraints.maxHeight;
              print(height);
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.menu_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "what are you looking for ??",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: height / 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: TextField(
                        maxLength: 30,
                        textInputAction: TextInputAction.search,
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                        controller: widget.textFieldController,
                        autofocus: false,
                        focusNode: foucsNode,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            color: Colors.white,
                            icon: Icon(
                              widget.textFieldController.text.length == 0
                                  ? Icons.search
                                  : Icons.clear,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              if (widget.textFieldController.text.length == 0) {
                                if (FocusScope.of(context).hasFocus)
                                  FocusScope.of(context)
                                      .requestFocus(foucsNode);
                              } else {
                                if (FocusScope.of(context).hasFocus) {
                                  widget.textFieldController.clear();
                                  setState(() {});
                                }
                              }
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.blue),
                        ),
                        onEditingComplete: () {
                          print("ok");
                          String text = widget.textFieldController.text;
                          widget.searchWord = text;
                          widget.searchHistory.add(text);
                          widget.textFieldController.clear();
                          setState(() {});
                          foucsNode.requestFocus();
                          foucsNode.unfocus();
                        },
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
