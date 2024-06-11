import 'package:flutter/material.dart';
import 'package:flutter_football/booking.dart';
import 'package:flutter_football/myteam.dart';
import 'package:flutter_football/webboard.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  // final String? teamName;
  // final int? numMem;

  // Constructor with the teamName parameter
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double btn_width = screenWidth * 0.48; // 47% ของความกว้างหน้าจอ
    double btn_font_size = 21;

    final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // Text color
      backgroundColor: Colors.blue[500], // Button background color
      minimumSize: Size(btn_width, 60), // Minimum button size
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), // Button border radius
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOMEPAGE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 18, 155),
      ),
      drawer: DrawerCustom(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * .48,
                child: Text("SHOW MAP HERE"),
              ),
              Container(
                // Search bar container
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 9, 0, 177),
                  borderRadius: BorderRadius.only(),
                ),
                child: Padding(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: gotoBooking,
                          style: customButtonStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/image/icon/football.png', // Replace with the correct path to your image
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                  width:
                                      5), // Add some space between the image and the text
                              Text(
                                'จองสนาม',
                                style: TextStyle(
                                  fontSize: btn_font_size,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: goto,
                          style: customButtonStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/image/icon/man.png', // Replace with the correct path to your image
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                  width:
                                      5), // Add some space between the image and the text
                              Text(
                                'สร้างทีม',
                                style: TextStyle(
                                  fontSize: btn_font_size,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: goto,
                          style: customButtonStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/image/icon/join.png', // Replace with the correct path to your image
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                  width:
                                      5), // Add some space between the image and the text
                              Text(
                                'เข้าร่วมทีม',
                                style: TextStyle(
                                  fontSize: btn_font_size,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: gotoMyTeam,
                          style: customButtonStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/image/icon/team.png', // Replace with the correct path to your image
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                  width:
                                      5), // Add some space between the image and the text
                              Text(
                                'ทีมของฉัน',
                                style: TextStyle(
                                  fontSize: btn_font_size,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: goto,
                          style: customButtonStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/image/icon/history.png', // Replace with the correct path to your image
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                  width:
                                      5), // Add some space between the image and the text
                              Text(
                                'ประวัติ',
                                style: TextStyle(
                                  fontSize: btn_font_size,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: gotoWebboard,
                          style: customButtonStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/image/icon/new_message.png', // Replace with the correct path to your image
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(
                                  width:
                                      5), // Add some space between the image and the text
                              Text(
                                'กระทู้',
                                style: TextStyle(
                                  fontSize: btn_font_size,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void gotoWebboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Webboard()), // Adjust this if needed
    );
  }

  void gotoMyTeam() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyTeam()),
    );
  }

  void gotoBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Booking()),
    );
  }

  void goto() {}
}
