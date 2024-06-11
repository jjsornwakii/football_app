import 'dart:async';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'createwebboard.dart';

class Webboard extends StatefulWidget {
  @override
  _WebboardState createState() => _WebboardState();
}

class _WebboardState extends State<Webboard> {
  String server = dotenv.get('SERVER') ?? '';
  String port = dotenv.get('PORT') ?? '';
  List<dynamic> webboardData = [];
  GetStorage box = GetStorage();
  String userId = '';

  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    userId = box.read('userid').toString();
    _commentController = TextEditingController();

    getAllWebboard();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'เว็บบอร์ด',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 18, 155),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.post_add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Createwebboard(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh:
            getAllWebboard, // ใช้ฟังก์ชัน getAllWebboard เมื่อมีการรีเฟรช
        child: ListView.builder(
          itemCount: webboardData.length,
          itemBuilder: (context, index) {
            print(" ${webboardData.length}");

            var record = webboardData[index];
            String user_Id = record['user_id'];

            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileWidget(user_Id),
                    Text(
                      record['webboard_subjectname'] ?? '',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      record['webboard_text'] ?? '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    if (record['webboard_image'] != null &&
                        record['webboard_image'].isNotEmpty) ...[
                      Image.network(
                        "http://$server:$port/football/api/user/${record['webboard_image']}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        headers: {'Cache-Control': 'max-age=86400'},
                      ),
                      SizedBox(height: 8.0),
                    ],
                    SizedBox(height: 8.0),
                    Text(
                      'Posted on: ${record['webboard_datetime'] ?? ''}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Action for like button
                            btnLikeToggle(userId, record['webboard_id'], index);
                          },
                          icon: Icon(Icons.thumb_up),
                          label: Text('Like'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue, // สีตัวอักษร
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text("${record['like_count']}"),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Action for comment button
                            displayCommentPopup(webboardData[index]);
                          },
                          icon: Icon(Icons.comment),
                          label: Text('Comment'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue, // สีตัวอักษร
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text("${record['comment_count']}"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getAllWebboard() async {
    try {
      String url = 'http://$server:$port/football/api/user/getAllWebboard.php';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          webboardData = json.decode(response.body);
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> btnLikeToggle(
      String user_id, String webboard_id, int index) async {
    try {
      String url = 'http://$server:$port/football/api/user/update_like.php';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'user_id': user_id, 'webboard_id': webboard_id}),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          if (data['status'] == 'insert') {
            webboardData[index]['like_count'] =
                int.parse(webboardData[index]['like_count'].toString()) + 1;
            webboardData[index]['like_status'] = true;
          } else {
            webboardData[index]['like_count'] =
                int.parse(webboardData[index]['like_count'].toString()) - 1;
            webboardData[index]['like_status'] = false;
          }
        });
        print("LIKE IT!");
      } else {
        print('Failed: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<Map<String, String>> fetchProfileImage(String user_Id) async {
    final response = await http.post(
      Uri.parse('http://$server:$port/football/api/user/getuserdetail.php'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'user_id': user_Id}),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return {
        'user_image': data['user_image'],
        'user_fullname': data['user_fullname'],
      };
    } else {
      throw Exception('Failed to load profile image');
    }
  }

  Widget profileWidget(String user_Id) {
    return FutureBuilder<Map<String, String>>(
      future: fetchProfileImage(user_Id),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Text('Loading'); //CircularProgressIndicator();
        // } else
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!['user_image']!.isEmpty) {
          return Text('Image not found');
        } else {
          return Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'http://$server:$port/football/api/user/${snapshot.data!['user_image']}',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                snapshot.data!['user_fullname'] ?? 'Unknown',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<dynamic>> fetchComments(String webboardId) async {
    try {
      final response = await http.post(
        Uri.parse('http://$server:$port/football/api/user/getallcomment.php'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'webboard_id': webboardId}),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        print(data);

        return data['comments'] ?? [];
      } else {
        print('Failed to fetch comments: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching comments: $error');
      return [];
    }
  }

  void displayCommentPopup(Map<String, dynamic> webboard) {
    FocusScopeNode focusScopeNode = FocusScopeNode();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
              ),
              FutureBuilder<List<dynamic>>(
                future: fetchComments(webboard['webboard_id']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('ยังไม่มีคนแสดงความคิดเห็น'));
                  } else {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var comment = snapshot.data![index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      'http://$server:$port/football/src/${comment['user_image']}',
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'คุณ ${comment['user_fullname']}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        comment['comment_datetime'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(comment['comment_text']),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              FocusScope(
                node: focusScopeNode,
                child: Container(
                  color: const Color.fromARGB(255, 210, 210, 210),
                  child: TextField(
                    controller: _commentController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Enter your comment...',
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                color: const Color.fromARGB(255, 112, 168, 214),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50), // กำหนดขนาดของปุ่ม
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red, // Text color
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('กลับ'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50), // กำหนดขนาดของปุ่ม
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green, // Text color
                        ),
                        onPressed: () {
                          submitComment(
                            userId,
                            webboard['webboard_id'],
                            _commentController.text,
                          );
                          Navigator.pop(context);
                          // Navigator.pop(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Webboard(),
                          //   ),
                          // );
                        },
                        child: const Text('ส่ง'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> submitComment(
      String userId, String webboardId, String commentText) async {
    try {
      String url = 'http://$server:$port/football/api/user/submit_comment.php';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'webboard_id': webboardId,
          'comment_text': commentText == "" ? null : commentText,
        }),
      );
      if (response.statusCode == 200) {
        _commentController.clear();
        print('คอมเมนต์สำเร็จ');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
