import 'package:flutter/material.dart';
import 'package:flutter_football/chat.dart';
import 'drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyTeam extends StatefulWidget {
  @override
  _MyTeamState createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  String? server = dotenv.env['SERVER'];
  String? port = dotenv.env['PORT'];
  final box = GetStorage();
  List<dynamic> teamDataList = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    final userId = box.read('userid');
    if (userId != null) {
      print("USERID: " + userId.toString());
      _fetchTeamDetails(userId);
    } else {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'User ID not found in storage.';
      });
    }
  }

  Future<void> _fetchTeamDetails(String userId) async {
    String apiUrl = 'http://$server:$port/football/api/user/get_teamdetail.php';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'user_id': userId}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('message')) {
          setState(() {
            hasError = true;
            errorMessage = responseBody['message'];
            isLoading = false;
          });
        } else {
          setState(() {
            teamDataList = responseBody['team_details'];
            isLoading = false;
          });
        }
      } else {
        setState(() {
          hasError = true;
          errorMessage =
              'Failed to load team details: ${response.reasonPhrase}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Failed to load team details: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> teamWidgets = [];
    int index = 0;

    while (index < teamDataList.length) {
      final teamData = teamDataList[index];
      teamWidgets.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  teamData['team_logo'] ??
                      'https://upload.wikimedia.org/wikipedia/th/1/1e/Buriram_united.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teamData['team_name'] ?? 'Unknown Team',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ผู้สร้าง: ' + teamData['user_fullname'],
                        ),
                        Text(
                          'จำนวนผู้เล่น: ${teamData['total_player']} / ${teamData['team_max']}',
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(),
                              ),
                            );
                          },
                          child: Text('แชท'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      index++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TEAM',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: DrawerCustom(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text(errorMessage))
              : ListView(
                  children: teamWidgets,
                ),
    );
  }
}
