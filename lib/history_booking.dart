import 'package:flutter/material.dart';
import 'package:flutter_football/historydetail.dart';
import 'package:flutter_football/review.dart';
import 'drawer.dart';

class HistoryBooking extends StatefulWidget {
  @override
  _HistoryBookingState createState() => _HistoryBookingState();
}

class _HistoryBookingState extends State<HistoryBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ประวัติ',
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
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://image-tc.galaxy.tf/wijpeg-ewq33b3h513wa4q6cipgpsmag/chang-arena-burirum-united-stadium.jpg', // URL ของไอคอน
                          ),
                        ),
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
                                          'วันที่: 2024/12/18 ',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'เวลา: 19:00-21:00',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'สนามที่: 2',
                                          style: TextStyle(
                                            fontSize: 15,
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
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // กำหนดให้ Row มีขนาดเท่าที่จำเป็น
                                        children: [
                                          Icon(
                                            Icons.table_view_sharp,
                                            color: Colors.white,
                                            size: 15,
                                          ), // ไอคอน
                                          SizedBox(
                                              width:
                                                  5), // ระยะห่างระหว่างไอคอนกับข้อความ
                                          Text(
                                            'รออนุมัติ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(
                                            255,
                                            255,
                                            220,
                                            25), // กำหนดสีพื้นหลังของปุ่ม
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width: 5), // ระยะห่างระหว่างปุ่มและข้อความ
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            historydetail()), // Adjust this if needed
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.table_view_sharp,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(
                                        width:
                                            5), // ระยะห่างระหว่างไอคอนกับข้อความ
                                    Text(
                                      'รายละเอียด',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 95, 97, 155),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(),
                                  ),
                                ),
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
            // ตำแหน่งที่ต้องการเพิ่ม Container
            SizedBox(height: 20),
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
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://image-tc.galaxy.tf/wijpeg-ewq33b3h513wa4q6cipgpsmag/chang-arena-burirum-united-stadium.jpg', // URL ของไอคอน
                          ),
                        ),
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
                                          'วันที่: 2024/10/12 ',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'เวลา: 19:00-21:00',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'สนามที่: 2',
                                          style: TextStyle(
                                            fontSize: 15,
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
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // กำหนดให้ Row มีขนาดเท่าที่จำเป็น
                                        children: [
                                          Icon(
                                            Icons.done_outlined,
                                            color: Colors.white,
                                            size: 15,
                                          ), // ไอคอน
                                          SizedBox(
                                              width:
                                                  5), // ระยะห่างระหว่างไอคอนกับข้อความ
                                          Text(
                                            'เสร็จสิ้น',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 24,
                                            122, 0), // กำหนดสีพื้นหลังของปุ่ม
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width: 5), // ระยะห่างระหว่างปุ่มและข้อความ
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            review()), // Adjust this if needed
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.table_view_sharp,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(
                                        width:
                                            5), // ระยะห่างระหว่างไอคอนกับข้อความ
                                    Text(
                                      'รีวิว',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 12, 196, 206),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 5), // ระยะห่างระหว่างปุ่มและข้อความ
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            historydetail()), // Adjust this if needed
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.table_view_sharp,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(
                                        width:
                                            5), // ระยะห่างระหว่างไอคอนกับข้อความ
                                    Text(
                                      'รายละเอียด',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 95, 97, 155),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(),
                                  ),
                                ),
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
