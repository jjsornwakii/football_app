import 'package:flutter/material.dart';
import 'package:flutter_football/history.dart';
import 'dart:io';

class Bookingdetail_3 extends StatelessWidget {
  final DateTime date;
  final String selectedTime;
  final String selectedField;
  final File transferProof;

  const Bookingdetail_3({
    required this.date,
    required this.selectedTime,
    required this.selectedField,
    required this.transferProof,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ยืนยันการจอง',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ยืนยันการจอง',
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
                  '${date.year}/${date.month}/${date.day}',
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
                  selectedTime,
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
                  selectedField,
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
              child: Image.file(
                transferProof,
                fit: BoxFit.contain, // ใช้ BoxFit.contain เพื่อแสดงภาพเต็ม
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // เมื่อกดปุ่ม จะทำการเปลี่ยนหน้าไปยังหน้า History
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(
                      date: date,
                      selectedTime: selectedTime,
                      selectedField: selectedField,
                      transferProof: transferProof,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('ยืนยัน'),
            ),
          ],
        ),
      ),
    );
  }
}
