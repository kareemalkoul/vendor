import 'package:flutter/material.dart';

class VendorRowInfoEditing extends StatefulWidget {
  final String title;
  String descraption;
  final int maxlines;
  final void Function(String) onFieldSubmitted;
  final void Function(String) onChanged;

  final TextInputType textInputType;
  final bool obscureText;
  VendorRowInfoEditing(
      {this.title,
      this.descraption,
      this.maxlines = 1,
      this.onFieldSubmitted,
      this.textInputType = TextInputType.name,
      this.obscureText = false,
      this.onChanged});

  @override
  _VendorRowInfoEditingState createState() => _VendorRowInfoEditingState();
}

class _VendorRowInfoEditingState extends State<VendorRowInfoEditing> {
  TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.descraption);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 10, 20),
      child: TextFormField(
        obscureText: widget.obscureText,
        maxLines: widget.maxlines,
        keyboardType: widget.textInputType,
        controller: controller,
        decoration: InputDecoration(
          labelText: "${widget.title}",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
        ),
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
      ),
    );
  }
}
