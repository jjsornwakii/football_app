import 'package:flutter/material.dart';
import 'package:flutter_football/myteam.dart';
import 'drawer.dart';
import 'dart:io';

class createteam_1 extends StatefulWidget {
  final String? teamName;
  final int? numMem;
  final File? image; // Add this line to receive the image

  createteam_1({
    Key? key,
    this.teamName,
    this.numMem,
    this.image, // Add this line to receive the image
  }) : super(key: key);

  @override
  _createteam_1State createState() => _createteam_1State();
}

class _createteam_1State extends State<createteam_1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOMEPAGE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: DrawerCustom(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // Search bar container
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 9, 0, 177),
                borderRadius: BorderRadius.only(),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ค้นหาสนาม',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(),
                border: Border(bottom: BorderSide(color: Colors.black)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.0,
                        bottom: 10.0,
                        right: 15.0), // เพิ่ม right padding
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: widget.image != null
                              ? Image.file(widget.image!)
                              : Icon(Icons.add_photo_alternate_rounded,
                                  size: 70, color: Colors.grey[800]),
                        ),

                        SizedBox(
                          width: 10,
                        ), // เพิ่มช่องว่างระหว่างไอคอนและข้อความ
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.teamName}',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ผู้สร้างทีม: สมจิต',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'ผู้เล่นจำนวนในทีมขณะนี้ ${widget.numMem}/14',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            10.0), // เพิ่ม padding ทางซ้ายของปุ่ม
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyTeam()),
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // กำหนดให้ Row มีขนาดเท่าที่จำเป็น
                                        children: [
                                          Icon(
                                            Icons.person_add,
                                            color: Colors.white,
                                            size: 16,
                                          ), // ไอคอน
                                          SizedBox(
                                              width:
                                                  5), // ระยะห่างระหว่างไอคอนกับข้อความ
                                          Text(
                                            'เข้าร่วมทีม',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 0,
                                            8, 152), // กำหนดสีพื้นหลังของปุ่ม
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(),
                border: Border(bottom: BorderSide(color: Colors.black)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.0,
                        bottom: 10.0,
                        right: 15.0), // เพิ่ม right padding
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/th/1/1e/Buriram_united.png', // URL ของไอคอน
                          ),
                        ),

                        // ส่วนที่ 2 ที่ต้องการให้ดึงจากหน้า createteam มาแสดง
                        SizedBox(
                          width: 10,
                        ), // เพิ่มช่องว่างระหว่างไอคอนและข้อความ
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Buriram',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ผู้สร้างทีม: สมจิต',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'ผู้เล่นจำนวนในทีมขณะนี้ 8/14',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            10.0), // เพิ่ม padding ทางซ้ายของปุ่ม
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyTeam()),
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // กำหนดให้ Row มีขนาดเท่าที่จำเป็น
                                        children: [
                                          Icon(
                                            Icons.person_add,
                                            color: Colors.white,
                                            size: 16,
                                          ), // ไอคอน
                                          SizedBox(
                                              width:
                                                  5), // ระยะห่างระหว่างไอคอนกับข้อความ
                                          Text(
                                            'เข้าร่วมทีม',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 0,
                                            8, 152), // กำหนดสีพื้นหลังของปุ่ม
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
