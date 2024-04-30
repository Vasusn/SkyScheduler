import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skyscheduler/Screens/Faculty/Home/faculty_home_screen.dart';

import '../../../../constants.dart';

class AddFacultyDataPage extends StatefulWidget {
  @override
  _AddFacultyDataPageState createState() => _AddFacultyDataPageState();
}

class _AddFacultyDataPageState extends State<AddFacultyDataPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _imageFile;
  String? _imageUrl;
  String _name = '';
  String _seatingArrangement = '';

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future<void> _imageUploadToCloudinary() async {
  final url = Uri.parse("https://api.cloudinary.com/v1_1/vasunageshri/upload");
  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = 'skyscheduler'
    ..files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));
  final response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    final jsonMap = jsonDecode(responseString); // Use jsonDecode instead of JsonDecoder

    setState(() {
      _imageUrl = jsonMap['secure_url']; // Assuming 'secure_url' contains the uploaded image URL
    });
  } else {
    print('Failed to upload image. Status code: ${response.statusCode}');
  }
}

  Future<void> _addFacultyData() async {
    await _imageUploadToCloudinary();
    try {
      await _firestore.collection('faculties').doc(_name).set({
        'name': _name,
        'seating_arrangement': _seatingArrangement,
        'timetable_url': _imageUrl,
      }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>FacultyHomeScreen())));
      // Clear input fields after adding data
      setState(() {
        _name = '';
        _seatingArrangement = '';
       
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Faculty data added successfully')));
    } catch (e) {
      print('Error adding faculty data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Faculty Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Seating Arrangement'),
                onChanged: (value) {
                  setState(() {
                    _seatingArrangement = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Upload Timetable Image'),
              ),
              // SizedBox(height: 16.0),
              if(_imageFile != null) ... [
                    SizedBox(
                    child:
                     InteractiveViewer(
                      panEnabled: false, // Set it to false
                      boundaryMargin: EdgeInsets.all(50),
                      minScale: 0.5,
                      maxScale: 3,
                      child: 
                      
                      Image.file(
                        _imageFile!,
                        width: defaultPadding * 25,
                        // height: defaultPadding * 25,
                        fit: BoxFit.cover,
                      ),
                    ),
                   ),
              ],
              
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addFacultyData,
                child: Text('Add Faculty Data'),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
