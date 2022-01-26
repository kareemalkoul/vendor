import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kemoColor = Colors.green;

class SearchBarTextField extends StatefulWidget {
  final controller;
  final Set<String> lastSearch;
  const SearchBarTextField(
      {@required this.controller, @required this.lastSearch});
  @override
  _SearchBarTextFieldState createState() => _SearchBarTextFieldState();
}

class _SearchBarTextFieldState extends State<SearchBarTextField> {
  FocusNode foucsNode;

  @override
  void initState() {
    super.initState();
    foucsNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 30,
      textInputAction: TextInputAction.search,
      buildCounter: (BuildContext context,
              {int currentLength, int maxLength, bool isFocused}) =>
          null,
      controller: widget.controller,
      autofocus: true,
      focusNode: foucsNode,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          color: Colors.white,
          icon: Icon(
            Icons.arrow_back_outlined,
            color: kemoColor,
          ),
          onPressed: () {
            foucsNode.unfocus();

            //TODO: Get.back();
          },
        ),
        suffixIcon: widget.controller.text.length == 0
            ? IconButton(
                icon: Icon(Icons.mic), color: kemoColor, onPressed: () {})
            : IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.clear,
                  color: Colors.blue,
                ),
                onPressed: () {
                  if (FocusScope.of(context).hasFocus) {
                    widget.controller.clear();
                    setState(() {});
                  }
                },
              ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.all(10),

        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(25),
        //   borderSide: BorderSide(color: Colors.white, width: 1),
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        hintText: "Search...",
        hintStyle: TextStyle(fontWeight: FontWeight.w300, color: kemoColor),
      ),
      onEditingComplete: () {
        print("ok");
        String text = widget.controller.text;
        // widget.searchWord = text;
        // widget.searchHistory.add(text);
        // widget.controller.clear();
        setState(() {});
        // foucsNode.requestFocus();
        // foucsNode.unfocus();

        print("${widget.controller.text}");
        print("$text");

        widget.lastSearch.add(text);
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        // Get.to(
        //     Result(
        //       wordSearch: text,
        //     ),
        //     transition: Transition.fade);

        // showMaterialModalBottomSheet(
        //   animationCurve: Curves.bounceIn,
        //   expand: false,
        //   builder: (BuildContext context) {
        //     SystemChannels.textInput
        //         .invokeMethod('TextInput.hide');
        //     print("${widget.textFieldController.text}");
        //     return ResultBody(
        //       searchWord: widget.searchWord,
        //     );
        //   },
        //   context: context,
        // );
      },
      onChanged: (_) {
        setState(() {});
      },
    );
  }
}
