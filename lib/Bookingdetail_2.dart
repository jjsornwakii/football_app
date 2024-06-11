import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_football/Bookingdetail_3.dart';

class Bookingdetail_2 extends StatefulWidget {
  final DateTime date;
  final String selectedTime;
  final String selectedField;

  const Bookingdetail_2(this.date, this.selectedTime, this.selectedField,
      {Key? key})
      : super(key: key);

  @override
  State<Bookingdetail_2> createState() => _Bookingdetail_2State();
}

class _Bookingdetail_2State extends State<Bookingdetail_2> {
  File? _image;

  Future<void> _openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _navigateToBookingdetail3() {
    if (_image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bookingdetail_3(
            date: widget.date,
            selectedTime: widget.selectedTime,
            selectedField: widget.selectedField,
            transferProof: _image!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณาแนบหลักฐานการโอน')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'กรุณาตรวจสอบข้อมูล',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'วันที่:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${widget.date.year}/${widget.date.month}/${widget.date.day}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'เวลา:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${widget.selectedTime}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'สนามที่:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${widget.selectedField}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'เวลาจำนวน 2 ชั่วโมง ราคา 500 บาท',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(),
              child: _image != null
                  ? Image.file(
                      _image!,
                      fit:
                          BoxFit.contain, // ใช้ BoxFit.contain เพื่อแสดงภาพเต็ม
                    )
                  : Image.asset(
                      'assets/image/qr.png',
                      fit:
                          BoxFit.contain, // ใช้ BoxFit.contain เพื่อแสดงภาพเต็ม
                    ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openImagePicker,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('แนบหลักฐานการโอน'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _navigateToBookingdetail3,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('ต่อไป'),
            ),
          ],
        ),
      ),
    );
  }
}
