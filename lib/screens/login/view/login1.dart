import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/onlanding/view/onlanding.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor));
    //  print(FocusScope.of(context));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  child: EcoMarketLogo(),
                  padding: EdgeInsets.all(5),
                ),
                AutoSizeText("welcome", style: TextStyle(fontSize: 30)),
                LoginTextField(
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  Text: "Email",
                  width: 400,
                  onFieldSubmitted: (_) => FocusScopeNode().nextFocus(),
                ),
                LoginTextField(
                    keyboardType: TextInputType.visiblePassword,
                    Text: "password",
                    prefixIcon: Icon(Icons.lock),
                    isPasswordField: true),
                LoginButton(
                  nameButton: "Login",
                ),
                LoginButton(
                  nameButton: "Sing up",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String nameButton;
  final Color color;
  final double width;
  final double height;
  const LoginButton({
    Key key,
    @required this.nameButton,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height??50,
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(color ?? primaryColor),
            elevation: MaterialStateProperty.all<double>(0),
            shape: MaterialStateProperty.all<OutlinedBorder>()),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            nameButton,
            style: TextStyle(fontSize: 20),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  bool showPassword = false;
  final Widget prefixIcon;
  final String Text;
  final double height;
  final double width;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final Function(String) validator;
  final Function(String) onFieldSubmitted;

  LoginTextField(
      {Key key,
      this.prefixIcon,
      @required this.Text,
      this.height,
      this.width,
      this.isPasswordField = false,
      this.keyboardType,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      constraints: BoxConstraints(
          minWidth: width ?? 0.0,
          minHeight: height ?? 0.0,
          maxWidth: width ?? double.infinity),
      child: GetBuilder<GetxController>(
        init: LoginTextFieldController(),
        builder: (controller) => Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            focusNode: new FocusNode(),
            onFieldSubmitted: onFieldSubmitted,
            textInputAction: TextInputAction.next,
            validator: validator,
            keyboardType: keyboardType,
            enableSuggestions: !isPasswordField,
            obscureText: isPasswordField ? !showPassword : false,
            decoration: InputDecoration(
              hintText: Text,
              prefixIcon: prefixIcon,
              suffixIcon: isPasswordField
                  ? ShowPassordIcon(
                      showPassword: showPassword,
                      onPressed: () {
                        showPassword = !showPassword;
                        controller.update();
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextFieldController extends GetxController {
  void update([List<Object> ids, bool condition = true]) {
    super.update(ids, condition);
  }
}

class ShowPassordIcon extends StatelessWidget {
  bool showPassword;
  Function() onPressed;
  ShowPassordIcon({Key key, this.showPassword, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: showPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      onPressed: onPressed,
    );
  }
}

class EcoMarketLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(200),
      width: getWidth(200),
      child: Image.asset(
        "images/logo.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

// extension Utility on BuildContext {
//   void nextEditableTextFocus() {
//     do {
//       FocusScope.of(this).nextFocus();
//     } while (FocusScope.of(this).focusedChild.context.widget is! EditableText);
//   }
// }
