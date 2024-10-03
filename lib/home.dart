import 'package:cats_dogs_classifier/about.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as devtools;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? filePath;
  String label = '';
  double confidence = 0.0;

  Future<void> _tfLteInit() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  pickImageGallery() async {
    final ImagePicker picker = ImagePicker(); // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        //TODO:Edit these params later if req
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    _tfLteInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        title: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Teachable Machine",
                style: Theme.of(context).textTheme.bodyLarge),
            Text(
              "Cats and Dogs Classifier",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ],
        ),
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //goto about page
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const About()));
        },
        tooltip: "About",
        mini: true,
        child: const Icon(Icons.info_outline),
      ),
      body: Center(
        child: Column(
          children: [
            if (filePath != null)
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  elevation: 20,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 350,
                        width: double.infinity,
                        child: Image.file(
                          filePath!,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Label: $label",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Confidence: ${confidence.toStringAsFixed(2)}%",
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(68.0),
                child: Image.asset(
                  "assets/catdog_transparent.png",
                  // fit: BoxFit.contain,
                  // width: 250,
                ),
              ),
            ElevatedButton.icon(
                onPressed: pickImageGallery,
                label: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text("Pick an Image"),
                ),
                icon: const Icon(Icons.image)),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton.icon(
                onPressed: pickImageCamera,
                label: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text("Snap a picture"),
                ),
                icon: const Icon(Icons.camera_alt)),
          ],
        ),
      ),
    );
  }
}
