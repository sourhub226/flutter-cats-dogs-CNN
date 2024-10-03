import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  Future<void> _launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Text(
              "What does this app do?",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      const TextSpan(
                          text:
                              "With the use of a Convolutional Neural Network (CNN), this app can intelligently classify the image you input into cats and dogs. The deep learning model is built using Google's "),
                      //add teachable machine link
                      TextSpan(
                          text: "Teachable Machine",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                          // add link to teachable machine
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchInBrowser(
                                  "https://teachablemachine.withgoogle.com/");
                            }),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      const TextSpan(
                          text:
                              "The dataset used to build the model comes from "),
                      TextSpan(
                          text: "Kaggle",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                          // add link to teachable machine
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchInBrowser(
                                  "https://www.kaggle.com/tongpython/cat-and-dog");
                            }),
                      const TextSpan(
                          text:
                              ", and it contains over 10,000 pictures of cats and dogs that were supplied as training input."),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      const TextSpan(
                          text:
                              "This app does not include any advertising and is completely free to use. It is built using Flutter and its source code is hosted on "),
                      TextSpan(
                          text: "GitHub",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                          // add link to teachable machine
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchInBrowser(
                                  "https://github.com/sourhub226/flutter-cats-dogs-CNN");
                            }),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => _launchInBrowser(
                        "https://github.com/sourhub226/flutter-cats-dogs-CNN/issues"),
                    child: Text(
                      "Need Help?",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(child: Container()),

            //button for rate and review with icon
            ElevatedButton.icon(
              onPressed: () {
                //add rate and review link
                _launchInBrowser(
                    "market://details?id=com.ml.cats_dogs_classifier");
              },
              icon: const Icon(Icons.star),
              label: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Rate and Review"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Share.share(
                    "Check out this cool app that can classify images of cats and dogs! \n https://play.google.com/store/apps/details?id=com.ml.cats_dogs_classifier");
              },
              icon: const Icon(Icons.share),
              label: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Share app"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Made with ❤️ by a self-taught developer",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: const Text("v2.0.0"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
