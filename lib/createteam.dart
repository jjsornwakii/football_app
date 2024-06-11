import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_football/createteam_1.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  File? _image;
  TextEditingController _teamNameController =
      TextEditingController(); // TextEditingController สำหรับชื่อทีม
  TextEditingController _numMembersController =
      TextEditingController(); // TextEditingController สำหรับจำนวนสมาชิก

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _createTeam() {
    String teamName = _teamNameController.text;
    int numMembers = int.tryParse(_numMembersController.text) ??
        0; // Get the number of members
    // Pass both the entered data and the number of members to the createteam_1 page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => createteam_1(
          teamName: teamName,
          numMem: numMembers, // Pass the number of members
          image: _image, // Pass the selected image
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CREATETEAM',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(left: 18.0),
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(Icons.add_photo_alternate_rounded,
                          size: 70, color: Colors.grey[800])
                      : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: _teamNameController,
                  decoration: InputDecoration(
                    hintText: 'ชื่อทีม',
                    icon: Icon(Icons.sports_score_sharp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: _numMembersController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[1-9]$|^1[0-4]$')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'จำนวนสมาชิกที่ต้องการรับสูงสุด 14 คน ',
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createTeam,
              child: Text('Create Team'),
            ),
          ],
        ),
      ),
    );
  }
}
