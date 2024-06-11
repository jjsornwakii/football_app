import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_football/main.dart';
import 'package:flutter_football/booking.dart';
import 'package:flutter_football/createteam.dart';
import 'package:flutter_football/history_booking.dart';
import 'package:flutter_football/home.dart';
import 'package:flutter_football/myteam.dart';
import 'package:flutter_football/webboard.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({super.key});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  String? server = dotenv.env['SERVER'];
  String? port = dotenv.env['PORT'];
  String userId = '';
  String imagePath = '';
  GetStorage box = GetStorage();
  Map<String, dynamic>? userDetail;

  @override
  void initState() {
    super.initState();
    userId = box.read('userid').toString();
    _fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    print("image path ${userDetail?['user_image']}");

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                //color: Color.fromARGB(255, 9, 0, 177),
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(
                    255, 9, 0, 177), // เริ่ม gradient จากสีที่คุณต้องการ
                Color.fromARGB(
                    255, 225, 148, 133), // สิ้นสุด gradient ที่สีที่คุณต้องการ
              ],
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10), // Space between rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (userDetail != null && userDetail!['user_image'] != null)
                      ClipOval(
                        child: Image.network(
                          'http://$server:$port/football/api/user/${userDetail!['user_image']}',
                          width: 80, // Adjust size as needed
                          height: 80, // Adjust size as needed
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),

                    SizedBox(width: 10), // Space between rows
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ชื่อ ${userDetail?['user_fullname'] ?? ''}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'email : ${userDetail?['user_email'] ?? ''}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'ID:${userDetail?['user_id'] ?? ''}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Add more Text widgets as needed
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit_calendar_rounded, color: Colors.white),
            title: Text(
              'จองสนาม',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            tileColor: Color.fromARGB(255, 50, 44, 162),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Booking()), // Adjust this if needed
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.group_add, color: Colors.white),
            title: Text(
              'สร้างทีม',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            tileColor: Color.fromARGB(255, 50, 44, 162),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateTeam()), // Adjust this if needed
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.group, color: Colors.white),
            title: Text(
              'เข้าร่วมทีม',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            tileColor: Color.fromARGB(255, 50, 44, 162),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()), // Adjust this if needed
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.groups, color: Colors.white),
            title: Text(
              'ทีมของฉัน',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            tileColor: Color.fromARGB(255, 50, 44, 162),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyTeam()), // Adjust this if needed
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.white),
            title: Text(
              'ประวัติ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            tileColor: Color.fromARGB(255, 50, 44, 162),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HistoryBooking()), // Adjust this if needed
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.article, color: Colors.white),
            title: Text(
              'กระทู้',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            tileColor: Color.fromARGB(255, 50, 44, 162),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Webboard(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text(
              'ออกจากระบบ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            tileColor: Color.fromARGB(255, 35, 17, 147),
            onTap: () {
              //box.remove('userid');
              box.erase();

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHome()), // Adjust this if needed
              );
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> getUserData(Map<String, dynamic> data) async {
    String jsonData = jsonEncode(data);
    final response = await http.post(
      Uri.parse("http://$server:$port/football/api/user/getuserdetail.php"),
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );

    if (response.statusCode == 200) {
      // Successful response, handle data here
      print('Data posted successfully');
      return jsonDecode(response.body);
    } else {
      // Error occurred, handle it here
      print('Error posting data: ${response.statusCode}');
      throw Exception('Failed to post data');
    }
  }

  Future<void> _fetchUserDetails() async {
    // Prepare user data
    Map<String, dynamic> userData = {"user_id": userId};

    try {
      // Call getUserData and handle the s
      final response = await getUserData(userData);
      setState(() {
        userDetail = response;
      });
      print(response);
      print("my id is ${userDetail?['user_id']}");
    } on Exception catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
