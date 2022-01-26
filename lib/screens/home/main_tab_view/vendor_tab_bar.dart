// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class TabBarVendor extends StatelessWidget {
//   final TabController controller;
//   const TabBarVendor({this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: AppBar().preferredSize.height,
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: TabBar(
//         controller: controller,
//         indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
//         indicator: BoxDecoration(
//             borderRadius: BorderRadius.circular(25.0), color: Colors.green),
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.black,
//         tabs: [
//           Tab(icon: Icon(Icons.store)),
//           Tab(icon: FaIcon(FontAwesomeIcons.boxes)),
//           Tab(icon: Icon(Ionicons.md_notifications)),
//           Tab(icon: Icon(Ionicons.md_add_circle))
//         ],
//       ),
//     );
//   }
// }
