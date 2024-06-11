import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'webboard.dart'; // นำเข้าคลาส Webboard
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:typed_data';

class Createwebboard extends StatefulWidget {
  const Createwebboard({Key? key}) : super(key: key);

  @override
  State<Createwebboard> createState() => _CreatewebboardState();
}

class _CreatewebboardState extends State<Createwebboard> {
  File? _image;
  TextEditingController _topicController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  String? server = dotenv.env['SERVER'];
  String? port = dotenv.env['PORT'];
  String userId = '';
  String imagePath = '';
  GetStorage box = GetStorage();
  Map<String, dynamic>? userDetail;

  @override
  void initState() {
    super.initState();
    userId = box.read('userid');

    print(userId);
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _createTopic() async {
    String topic = _topicController.text;
    String text = _textController.text;

    // Get current datetime in UTC
    DateTime now = DateTime.now().toUtc();

    // Convert to Thai timezone (UTC+7)
    DateTime thaiDatetime = now.add(Duration(hours: 7));

    ///// api String
    String apiUrl = 'http://$server:$port/football/api/user/uploadwebboard.php';

    String? base64Image;
    if (_image != null) {
      // Compress image before uploading
      List<int> imageBytes = await _image!.readAsBytes();
      Uint8List uint8List = Uint8List.fromList(imageBytes);

      int maxSize = 500 * 1024 * 4; // Max size in bytes
      int imageLength = imageBytes.length;

      // Calculate compression quality
      double quality = 1.0;
      if (imageLength > maxSize) {
        quality = maxSize / imageLength;
      }

      int qualityInt = (quality * 100).toInt();

      if (qualityInt > 100)
        qualityInt = 100; // Ensure quality doesn't exceed 100%

      // Compress image
      imageBytes = await FlutterImageCompress.compressWithList(
        uint8List,
        quality: qualityInt,
      );
      base64Image = base64Encode(imageBytes);
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': userId,
        'webboard_subjectname': topic,
        'webboard_image': base64Image,
        'webboard_text': text,
        'webboard_datetime': thaiDatetime.toIso8601String(),
        'webboard_status': 1,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final responseString =
          response.body.substring(response.body.indexOf('{'));

      final responseData = json.decode(responseString);

      if (responseData['status'] == 'success') {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Webboard()),
        // );
      } else {
        // Handle login error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } else {
      // Handle server error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Server error. Please try again later.')),
      );
    }

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Webboard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'สร้างเว็บบอร์ด',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 18, 155),
      ),
      body: Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              GestureDetector(
                onTap: _pickImage,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.0), // ปรับขนาดตามต้องการ
                  child: Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[200],
                    child: Center(
                      child: _image == null
                          ? Icon(Icons.add_photo_alternate_rounded,
                              size: 70, color: Colors.grey[800])
                          : Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _topicController,
                    decoration: const InputDecoration(
                      hintText: 'หัวข้อที่ต้องการโพส',
                      icon: Icon(Icons.post_add),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'เนื้อหาโพส',
                      icon: Icon(Icons.text_snippet),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 60.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createTopic,
                child: const Text('Post'),
              ),
            ],
          )))),
    );
  }
}
