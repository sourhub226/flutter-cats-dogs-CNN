import 'dart:io';
import 'package:catsanddogs/aboutpage.dart';
import 'package:catsanddogs/main.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File _image;
  List _output;
  var imageHeight;
  var imageWidth;

  @override
  void initState() {
    super.initState();

    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  setImageSize(image) async {
    if (image == null) return;
    File temp = new File(image.path);
    var decodedImage = await decodeImageFromList(temp.readAsBytesSync());
    setState(() {
      imageHeight = decodedImage.height;
      imageWidth = decodedImage.width;
    });
    print(decodedImage.width);
    print(decodedImage.height);
  }

  pickCameraImage() async {
    var image = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (image == null) return null;
    setImageSize(image);
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 0);
    if (image == null) return null;
    setImageSize(image);
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 20,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/ml_model/model_unquant.tflite",
        labels: "assets/ml_model/labels.txt");
  }

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Teachable Machine CNN",
                    style: TextStyle(
                      color: MyApp.labelColor,
                      // fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      "Cats and Dogs Classifier",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: MyApp.labelColor,
        elevation: 0,
        tooltip: "About",
        mini: true,
        child: Icon(Icons.info_outline),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutPage()),
          );
        },
      ),
      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                _loading
                    ? Container(
                        width: 230,
                        height: 230,
                        child: Column(
                          children: [
                            Image.asset("assets/images/catdog_transparent.png"),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: (imageHeight - imageWidth) >= 0
                                  ? MediaQuery.of(context).size.height / 2.3
                                  : MediaQuery.of(context).size.height / 3.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minWidth: 1, minHeight: 1),
                                    child: Image.file(_image),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _output != null
                                ? Container(
                                    width: 120,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 2, 6, 3),
                                      child: FittedBox(
                                        // fit: BoxFit.fitWidth,
                                        child: Text(
                                          "Detection: ${_output[0]["label"]}",
                                          style: TextStyle(
                                            color: MyApp.labelColor,
                                            // fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : () {},
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).accentColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: pickGalleryImage,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.photo_album,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  Text(
                                    "Pick an image",
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      // fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).accentColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final status = await Permission.camera.request();
                            if (status == PermissionStatus.granted) {
                              print('Permission granted');
                              pickCameraImage();
                            } else if (status == PermissionStatus.denied) {
                              print(
                                  'Permission denied. Show a dialog and again ask for the permission');
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                        title: Text("Permission denied"),
                                        content: Text(
                                            "Allow camera permission to click a picture."),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        actions: [
                                          TextButton(
                                              style: ButtonStyle(
                                                  overlayColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Theme.of(
                                                              context)
                                                          .accentColor
                                                          .withOpacity(0.2))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor)))
                                        ],
                                      ));
                            } else if (status ==
                                PermissionStatus.permanentlyDenied) {
                              print('Take the user to the settings page.');
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Permission denied"),
                                        content: Text(
                                            "Camera permission has been revoked. Enable camera permission in settings to click a photo."),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        actions: [
                                          TextButton(
                                              style: ButtonStyle(
                                                  overlayColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Theme.of(
                                                              context)
                                                          .accentColor
                                                          .withOpacity(0.2))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                openAppSettings();
                                              },
                                              child: Text("OPEN SETTINGS",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor)))
                                        ],
                                      ));
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.camera_enhance,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  Text(
                                    "Snap a picture",
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      // fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
