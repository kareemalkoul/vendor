import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/requests_handling/prefhalndler.dart';
import 'package:vendor/requests_handling/requests.dart';
import 'package:vendor/screens/drawer/story/controller/storycontroller.dart';
import 'package:vendor/screens/getget/view/getscreen.dart';
import 'package:vendor/screens/home/controller/homecontroller.dart';
import 'package:vendor/screens/home/main_tab_view/vendor_details/controller/homecontroller.dart';
import 'package:vendor/screens/login/view/login1.dart';
import 'package:vendor/screens/onlanding/view/onlanding.dart';
import 'package:vendor/screens/splashscreen/view/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/widgets/Future_scafold.dart';
import 'configs/size.dart';
import 'screens/login/view/login.dart';

var initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  PrefHandler().init(await SharedPreferences.getInstance());
  MediaQueryData mediaQueryData =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  SizeConfig.screenHeight = mediaQueryData.size.height;
  SizeConfig.screenWidth = mediaQueryData.size.width;
  MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  SizeConfig.bodyHeight = SizeConfig.screenHeight -
      (AppBar().preferredSize.height +
          mediaQueryData.padding.top +
          mediaQueryData.padding.bottom);

  initScreen = prefs.getInt("isLogged");
  print(initScreen);

  runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [routeObserver],
      // key: UniqueKey(),
      textDirection: TextDirection.ltr,
      theme: ThemeData().copyWith(
        primaryColor: Color(0xff32A8C3),
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
      // home: Home5(),
      // home: initScreen == 0 || initScreen == null ? LogIn() : SplashScreen(),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

String getPrettyJSONString(jsonObject) {
  var encoder = new JsonEncoder.withIndent("     ");
  return encoder.convert(jsonObject);
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

// class Home4 extends StatelessWidget {
//   var data;
//   Future getData() async {
//     data = await Requests.getRequest(
//         "https://floating-badlands-10743.herokuapp.com/api/faq/all");
//     print(data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     getData();
//     return Scaffold(
//       body: FutureBuilder(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (data != null) {
//             return ListView(
//               children: [
//                 Container(
//                   child: Text("data"),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.refresh),
//                   onPressed: () async {},
//                 )
//               ],
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }

// class Home5 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureScafold(
//       nameScreen: "Story",
//       fetchData: StoryController.getStories,
//       data: [],
//     );
//   }
// }
