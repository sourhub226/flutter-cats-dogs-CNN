import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cats_dogs_classifier/about.dart';
import 'dart:io';
import 'dart:developer' as devtools;



class ClassifierPage extends StatefulWidget {
  const ClassifierPage({Key? key}) : super(key: key);

  @override
  _ClassifierPageState createState() => _ClassifierPageState();
}

class _ClassifierPageState extends State<ClassifierPage> {
  File? _image;
  String _label = 'No image selected';

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _label =
            'Classifying...'; // You would replace this with actual classification logic
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat & Dog Classifier'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_image != null)
                        Expanded(
                          child: Image.file(
                            _image!,
                            fit: BoxFit.contain,
                          ),
                        )
                      else
                        const Icon(
                          Icons.pets,
                          size: 100,
                          color: Colors.grey,
                        ),
                      const SizedBox(height: 16),
                      Text(
                        _label,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
