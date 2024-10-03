// import 'package:catsanddogs/main.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:package_info/package_info.dart';

// class AboutPage extends StatefulWidget {
//   @override
//   _AboutPageState createState() => _AboutPageState();
// }

// class _AboutPageState extends State<AboutPage> {
//   PackageInfo _packageInfo = PackageInfo(
//     appName: 'Unknown',
//     packageName: 'Unknown',
//     version: 'Unknown',
//     buildNumber: 'Unknown',
//   );

//   @override
//   void initState() {
//     super.initState();
//     _initPackageInfo();
//   }

//   Future<void> _initPackageInfo() async {
//     final PackageInfo info = await PackageInfo.fromPlatform();
//     setState(() {
//       _packageInfo = info;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "About",
//           style: TextStyle(color: Theme.of(context).accentColor),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints viewportConstraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: viewportConstraints.maxHeight,
//               ),
//               child: IntrinsicHeight(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(25.0),
//                       child: Image.asset(
//                         "assets/images/splash.png",
//                         height: 160,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                       child: Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "What does this app do?",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                   color: Theme.of(context).accentColor),
//                             ),
//                             SizedBox(
//                               height: 3,
//                             ),
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text:
//                                           "With the use of a Convolutional Neural Network (CNN), this app can intelligently classify the image you input into cats and dogs. "),
//                                   TextSpan(
//                                     text:
//                                         "The deep learning model is built using Google's ",
//                                   ),
//                                   TextSpan(
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () async {
//                                         var _url =
//                                             "https://teachablemachine.withgoogle.com/";
//                                         await canLaunch(_url)
//                                             ? await launch(_url)
//                                             : throw 'Could not launch $_url';
//                                       },
//                                     text: 'Teachable Machine. ',
//                                     style: new TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).accentColor),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text:
//                                           "The dataset used to build the model comes from "),
//                                   TextSpan(
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () async {
//                                         var _url =
//                                             "https://www.kaggle.com/tongpython/cat-and-dog";
//                                         await canLaunch(_url)
//                                             ? await launch(_url)
//                                             : throw 'Could not launch $_url';
//                                       },
//                                     text: 'Kaggle',
//                                     style: new TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).accentColor),
//                                   ),
//                                   TextSpan(
//                                       text:
//                                           ", and it contains over 10,000 pictures of cats and dogs that were supplied as training input."),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text:
//                                         "This app does not include any advertising and is completely free to use. The project is hosted on ",
//                                   ),
//                                   TextSpan(
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () async {
//                                         var _url =
//                                             "https://github.com/sourhub226/flutter-cats-dogs-CNN";
//                                         await canLaunch(_url)
//                                             ? await launch(_url)
//                                             : throw 'Could not launch $_url';
//                                       },
//                                     text: 'GitHub.',
//                                     style: new TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Theme.of(context).accentColor),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         var _url =
//                             "https://github.com/sourhub226/flutter-cats-dogs-CNN/issues";
//                         await canLaunch(_url)
//                             ? await launch(_url)
//                             : throw 'Could not launch $_url';
//                       },
//                       child: Row(
//                         children: [
//                           Container(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Text(
//                                   "Need Help?",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                       color: Theme.of(context).accentColor),
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       // A flexible child that will grow to fit the viewport but
//                       // still be at least as big as necessary to fit its contents.
//                       child: Container(),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Container(
//                         child: IntrinsicHeight(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               ElevatedButton(
//                                 style: ButtonStyle(
//                                   elevation: MaterialStateProperty.all(0),
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           Theme.of(context).accentColor),
//                                   shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   print("RATE");
//                                   showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (context) => AlertDialog(
//                                             backgroundColor:
//                                                 Theme.of(context).primaryColor,
//                                             title: Text("Rate this app"),
//                                             content: Text(
//                                                 "If you like this app, please take a moment to rate and review it on the Google Play Store! It's really beneficial to me, and it shouldn't take more than a minute of your time."),
//                                             actions: [
//                                               TextButton(
//                                                   style: ButtonStyle(
//                                                       overlayColor:
//                                                           MaterialStateProperty
//                                                               .all<Color>(Theme
//                                                                       .of(
//                                                                           context)
//                                                                   .accentColor
//                                                                   .withOpacity(
//                                                                       0.2))),
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Text(
//                                                     "NO THANKS",
//                                                     style: TextStyle(
//                                                         color: Theme.of(context)
//                                                             .accentColor),
//                                                   )),
//                                               TextButton(
//                                                   style: ButtonStyle(
//                                                     overlayColor:
//                                                         MaterialStateProperty
//                                                             .all<Color>(Theme
//                                                                     .of(context)
//                                                                 .accentColor
//                                                                 .withOpacity(
//                                                                     0.2)),
//                                                     backgroundColor:
//                                                         MaterialStateProperty
//                                                             .all<Color>(Theme
//                                                                     .of(context)
//                                                                 .accentColor),
//                                                   ),
//                                                   onPressed: () async {
//                                                     var _url =
//                                                         "market://details?id=${_packageInfo.packageName}";
//                                                     await canLaunch(_url)
//                                                         ? await launch(_url)
//                                                             .then((_) =>
//                                                                 Navigator.pop(
//                                                                     context))
//                                                         : throw 'Could not launch $_url';
//                                                   },
//                                                   child: Text(
//                                                     "OPEN PLAY STORE",
//                                                     style: TextStyle(
//                                                         color: Theme.of(context)
//                                                             .primaryColor),
//                                                   )),
//                                             ],
//                                           ));
//                                 },
//                                 child: SizedBox(
//                                   height: double.infinity,
//                                   width: MediaQuery.of(context).size.width / 3,
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.star,
//                                           color: Theme.of(context).canvasColor,
//                                         ),
//                                         SizedBox(
//                                           width: 5,
//                                         ),
//                                         Expanded(
//                                           child: Center(
//                                             child: Text(
//                                               "Rate and Review",
//                                               style: TextStyle(
//                                                 color: Theme.of(context)
//                                                     .canvasColor,
//                                                 // fontSize: 15,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 style: ButtonStyle(
//                                   elevation: MaterialStateProperty.all(0),
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           Theme.of(context).accentColor),
//                                   shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   Share.share(
//                                       "https://play.google.com/store/apps/details?id=${_packageInfo.packageName}");
//                                 },
//                                 child: SizedBox(
//                                   height: double.infinity,
//                                   width: MediaQuery.of(context).size.width / 3,
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.share,
//                                           color: Theme.of(context).canvasColor,
//                                         ),
//                                         SizedBox(
//                                           width: 5,
//                                         ),
//                                         Expanded(
//                                           child: Center(
//                                             child: Text(
//                                               "Share app",
//                                               style: TextStyle(
//                                                 color: Theme.of(context)
//                                                     .canvasColor,
//                                                 // fontSize: 15,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Container(
//                         // footer
//                         color: Theme.of(context).primaryColor,
//                         // height: 120.0,
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 "v${_packageInfo.version}",
//                                 style: TextStyle(
//                                     color: MyApp.labelColor, fontSize: 12),
//                               ),
//                               SizedBox(
//                                 height: 3,
//                               ),
//                               FittedBox(
//                                 child: Text(
//                                   "Created by a self-taught programmer",
//                                   style: TextStyle(
//                                       color: MyApp.labelColor, fontSize: 12),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


// // market://details?id=