// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  Image? processedImage;
  Map<String, dynamic>? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Center(child: Text('Preprocessing Phase')),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                image != null ? Image.file(image!) : Text("upload your image"),
                ElevatedButton(
                  onPressed: uploadImage,
                  child: Icon(Icons.upload_file),
                ),
                processedImage != null
                    ? processedImage!
                    : Text("wait to process your image"),
                ElevatedButton(
                  onPressed: () {
                    convert2string();
                  },
                  child: Icon(Icons.settings_applications_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future uploadImage() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;
    final temp = File(img.path);
    setState(() {
      image = temp;
    });
  }

  Future convert2string() async {
    if (image == null) return;
    String base64 = base64Encode(image!.readAsBytesSync());
    value = await postData(base64);
    String strprocessed = value!['processed'];
    final imageProcessed = base64Decode(strprocessed);

    setState(() {
      processedImage = Image.memory(imageProcessed);
    });
  }
}
