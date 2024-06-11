import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'Bookingdetail_1.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? server = dotenv.env['SERVER'];
  String? port = dotenv.env['PORT'];

  List<dynamic> stadiums = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStadiums();
  }

  Future<void> fetchStadiums() async {
    try {
      final response = await http.get(
          Uri.parse('http://$server:$port/football/api/user/show_stadium.php'));

      if (response.statusCode == 200) {
        setState(() {
          stadiums = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception(
            'Failed to load stadiums, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stadiumWidgets = [];
    int index = 0;
    while (index < stadiums.length) {
      final stadium = stadiums[index];
      stadiumWidgets.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'http://$server:$port/football/src/stadium_img/${stadium['stadium_image']}',
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
                          stadium['stadium_name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('สถานะ: ' + stadium['stadium_caption']),
                        Text('ราคา: ' +
                            stadium['stadium_price'].toString() +
                            ' บาท/ชม.'),
                        Text('เบอร์โทร: ' + stadium['stadium_tel']),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Bookingdetail_1(
                                  stadiumId: stadium['stadium_id'],
                                  stadiumName: '',
                                ),
                              ),
                            );
                          },
                          child: Text('จองสนาม'),
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
          'BOOKING',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 18, 155),
      ),
      drawer: DrawerCustom(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: stadiumWidgets,
            ),
    );
  }
}
