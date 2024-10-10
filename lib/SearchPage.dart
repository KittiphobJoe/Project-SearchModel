import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image; // ตัวแปรสำหรับเก็บภาพที่เลือก
  String _recognitionResult = ''; // ตัวแปรสำหรับเก็บผลการจำแนกประเภท

  @override
  void initState() {
    super.initState();
    loadModels(); // โหลดโมเดล
  }

  Future<void> loadModels() async {
    await Tflite.loadModel(
      model: "assets/mobilenet_model.tflite",
      labels: "assets/label.txt",
      isAsset: true,
    );

    await Tflite.loadModel(
      model: "assets/densenet_model.tflite",
      labels: "assets/label.txt",
      isAsset: true,
    );

    await Tflite.loadModel(
      model: "assets/xception_model.tflite",
      labels: "assets/label.txt",
      isAsset: true,
    );

    await Tflite.loadModel(
      model: "assets/nasnet_model.tflite",
      labels: "assets/label.txt",
      isAsset: true,
    );

    await Tflite.loadModel(
      model: "assets/mobilenetv2_model.tflite",
      labels: "assets/label.txt",
      isAsset: true,
    );
  }

  Future<void> detectImage(File image) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    var recognitionsList = []; // รายการเก็บผลลัพธ์

    var models = [
      {"name": "MobileNet", "model": "assets/mobilenet_model.tflite"},
      {"name": "DenseNet", "model": "assets/densenet_model.tflite"},
      {"name": "Xception", "model": "assets/xception_model.tflite"},
      {"name": "NASNet", "model": "assets/nasnet_model.tflite"},
      {"name": "MobileNetV2", "model": "assets/mobilenetv2_model.tflite"},
    ];

    for (var model in models) {
      await Tflite.loadModel(
        model: model["model"]!,
        labels: "assets/label.txt",
        isAsset: true,
      );
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        recognitions.sort((a, b) => (b['confidence'] as double).compareTo(a['confidence'] as double));
        recognitionsList.add('${model["name"]}: ${recognitions.first['label']} \n(Confidence: ${(recognitions.first['confidence'] as double).toStringAsFixed(4)})');
      }
    }

    setState(() {
      _recognitionResult = recognitionsList.join('\n'); // รวมผลลัพธ์จากโมเดลทั้งหมด
    });

    int endTime = DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหา'),
        backgroundColor: Color(0xFFA4C49A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'ค้นหาพืช',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ฟังก์ชันค้นหาเมื่อกดปุ่ม
              },
              child: Text('ค้นหา'),
            ),
            SizedBox(height: 20),
            if (_image != null)
              Column(
                children: [
                  Image.file(
                    _image!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _recognitionResult,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.black, size: 30),
                  onPressed: () async {
                    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                    if (photo != null) {
                      setState(() {
                        _image = File(photo.path);
                      });
                      detectImage(_image!); // เรียกใช้ฟังก์ชัน detectImage
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.image, color: Colors.black, size: 30),
                  onPressed: () async {
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        _image = File(image.path);
                      });
                      detectImage(_image!); // เรียกใช้ฟังก์ชัน detectImage
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
