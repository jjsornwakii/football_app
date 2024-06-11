import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Bookingdetail_1 extends StatefulWidget {
  final String stadiumId;
  final String stadiumName;

  const Bookingdetail_1(
      {required this.stadiumId, required this.stadiumName, Key? key})
      : super(key: key);

  @override
  State<Bookingdetail_1> createState() => _Bookingdetail_1State();
}

class _Bookingdetail_1State extends State<Bookingdetail_1> {
  String? server = dotenv.env['SERVER'];
  String? port = dotenv.env['PORT'];

  List<dynamic> substadiums = [];
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  String? selectedSubstadium;
  double? selectedPrice;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormat = DateFormat('HH:mm:ss');

  @override
  void initState() {
    super.initState();
    fetchSubStadiums();
  }

  Future<void> fetchSubStadiums() async {
    try {
      final response = await http.get(Uri.parse(
          'http://$server:$port/football/api/user/show_substadium.php?stadium_id=${int.parse(widget.stadiumId)}'));

      if (response.statusCode == 200) {
        setState(() {
          substadiums = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception(
            'Failed to load substadiums, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _confirmBooking() async {
    if (selectedSubstadium == null ||
        selectedTime == null ||
        selectedPrice == null) {
      // ในกรณีที่ข้อมูลไม่สมบูรณ์
      print('กรุณาเลือกข้อมูลให้ครบถ้วน');
      return;
    }

    // Extract booking details
    String bookingDate = dateFormat.format(selectedDate);
    String startTime = selectedTime!.split('-')[0].trim();
    String endTime = selectedTime!.split('-')[1].trim();
    int substadiumId = int.parse(selectedSubstadium!);

    // Prepare data for insertion
    Map<String, dynamic> data = {
      'timestart': '$bookingDate $startTime',
      'timeend': '$bookingDate $endTime',
      'substatium_price': selectedPrice,
      'booking_datetime': DateTime.now().toString(),
      'booking_status': 1, // 1 คือสถานะการจองที่เป็นไปได้
      'substadium_id': substadiumId,
      'payment_payment_id': 1, // สมมติว่าใช้วิธีการจ่ายเงินที่ payment_id = 1
      'user_id': 1, // สมมติว่ามี user_id = 1
    };

    // Send HTTP request to insert data
    try {
      final response = await http.post(
        Uri.parse('http://$server:$port/football/api/user/insert_booking.php'),
        body: json.encode(data), // Send booking data to PHP script
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Handle successful insertion
        print('บันทึกการจองสำเร็จแล้ว!');
      } else {
        // Handle insertion failure
        print('ไม่สามารถบันทึกการจองได้, รหัสสถานะ: ${response.statusCode}');
      }
    } catch (e) {
      print('เกิดข้อผิดพลาด: $e');
      // Handle insertion failure
    }
  }

  DropdownButton<String> _buildSubStadiumDropdown() {
    return DropdownButton<String>(
      hint: Text('เลือกสนามที่'),
      value: selectedSubstadium,
      isExpanded: true,
      onChanged: (String? newValue) {
        if (newValue != null) {
          // Check for null value
          setState(() {
            selectedSubstadium = newValue;
            var selectedSubstadiumDetails = substadiums.firstWhere(
                (substadium) =>
                    substadium['substadium_id'].toString() == newValue);
            selectedPrice = double.parse(
                selectedSubstadiumDetails['substatium_price'].toString());
          });
        }
      },
      items: substadiums.map<DropdownMenuItem<String>>((dynamic substadium) {
        return DropdownMenuItem<String>(
          value: substadium['substadium_id'].toString(),
          child: Row(
            children: [
              Image.asset(
                substadium['substadium_image'] != null
                    ? 'assets/image/${substadium['substadium_image']}'
                    : 'assets/image/default_image.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${substadium['substadium_name']} (ราคา: ${substadium['substatium_price']} บาท)',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จองสนาม'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'คุณต้องการจองสนาม ${widget.stadiumName}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('สนามที่', style: TextStyle(fontSize: 16)),
                  _buildSubStadiumDropdown(),
                  SizedBox(height: 16),
                  Text('วันที่', style: TextStyle(fontSize: 16)),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dateFormat.format(selectedDate)),
                          Icon(Icons.calendar_today, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('เวลา', style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    hint: Text('เลือกเวลา'),
                    value: selectedTime,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTime = newValue;
                      });
                    },
                    items: <String>['17:00-19:00', '19:00-21:00', '21:00-23:00']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: _confirmBooking,
                      child: Text('ต่อไป'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
