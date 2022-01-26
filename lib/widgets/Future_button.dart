import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureButton extends StatefulWidget {
  final Future Function() onPressed;
  final Widget child;

  FutureButton({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  _FutureButtonState createState() => _FutureButtonState();
}

class _FutureButtonState extends State<FutureButton> {
  bool isClosed = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () async {
        if (isClosed) {
          return;
        }

        setState(() {
          isClosed = true;
        });
        await widget.onPressed();

        setState(() {
          isClosed = false;
        });
      },
      child: isClosed ? CircularProgressIndicator() : widget.child,
    );
  }
}
