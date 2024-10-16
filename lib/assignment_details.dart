import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class AssignmentDetails extends StatefulWidget {
  final dynamic assignment;

  AssignmentDetails({Key? key, required this.assignment}) : super(key: key);

  @override
  _AssignmentDetailsState createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedFiles = [];
  File? _videoFile;
  bool _isFileUploaded = false; // Track if any file is uploaded

  // Record a video
  Future<void> recordVideo() async {
    // Request camera permission
    var status = await Permission.camera.request();

    if (status.isGranted) {
      try {
        final XFile? video = await _picker.pickVideo(
            source: ImageSource.camera, maxDuration: Duration(seconds: 60));

        if (video != null) {
          final Directory? appDir = await getExternalStorageDirectory();
          if (appDir != null) {
            final Directory cameraDir = Directory(path.join(appDir.path, 'Pictures'));
            if (!await cameraDir.exists()) {
              await cameraDir.create(recursive: true);
            }
            final File newFile = File('${cameraDir.path}/${video.name}');
            await video.saveTo(newFile.path);
            setState(() {
              _videoFile = newFile; // Update the video file
              _isFileUploaded = true; // Mark file as uploaded
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Video recorded: ${newFile.path}")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("No video recorded.")));
        }
      } catch (e) {
        print("Error recording video: $e");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error recording video: $e")));
      }
    } else if (status.isDenied) {
      // Optionally, you can request permission again or show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera permission is denied. Please enable it in app settings.")),
      );
      // Optionally, open app settings
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera permission is permanently denied. Please enable it in the app settings.")),
      );
      openAppSettings();
    }
  }

  // Select files
  Future<void> selectFiles() async {
    try {
      final List<XFile>? files = await _picker.pickMultiImage();
      if (files != null) {
        setState(() {
          _selectedFiles = files.map((file) => File(file.path)).toList();
          _isFileUploaded = _selectedFiles.isNotEmpty || _videoFile != null; // Check if any file is uploaded
        });
      }
    } catch (e) {
      print("Error selecting files: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error selecting files: $e")));
    }
  }

  // Remove selected file
  void removeFile(File file) {
    setState(() {
      _selectedFiles.remove(file);
      _isFileUploaded = _selectedFiles.isNotEmpty || _videoFile != null; // Update the uploaded status
    });
  }

  // Upload a video and files
  Future<void> uploadFiles() async {
    if (!_isFileUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No file uploaded.")),
      );
      return; // Prevent upload if no file is selected
    }

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://10.0.2.2:8000/api/vd/upload'));

      // Upload the video file if available
      if (_videoFile != null) {
        var videoStream = http.ByteStream(Stream.castFrom(_videoFile!.openRead()));
        var videoLength = await _videoFile!.length();
        var videoFile = http.MultipartFile('video', videoStream, videoLength,
            filename: path.basename(_videoFile!.path));
        request.files.add(videoFile);
      }

      // Upload selected files
      for (var file in _selectedFiles) {
        var fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
        var fileLength = await file.length();
        var fileUpload = http.MultipartFile('files[]', fileStream, fileLength,
            filename: path.basename(file.path));
        request.files.add(fileUpload);
      }

      // Send the request
      var response = await request.send();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Files uploaded successfully.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload files.")),
        );
      }
    } catch (e) {
      print("Error uploading files: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error uploading files: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assignment Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900], // Darker blue for the app bar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assignment title container
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assignment Title: ${widget.assignment['title']}",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Created By: ${widget.assignment['created_by']}",
                    style: TextStyle(
                        fontSize: 18, color: Colors.blue[600]),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Due Date: ${widget.assignment['due_date']}",
                    style: TextStyle(
                        fontSize: 16, color: Colors.redAccent),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Assignment description container
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.assignment['description'],
                    style: TextStyle(
                        fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Selected files display
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Files:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]),
                  ),
                  SizedBox(height: 8.0),
                  ..._selectedFiles.map((file) {
                    return ListTile(
                      title: Text(file.path.split('/').last),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeFile(file),
                      ),
                    );
                  }).toList(),
                  if (!_isFileUploaded) // Show message if no file is uploaded
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "No file uploaded.",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Buttons for recording and selecting files
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.videocam, color: Colors.white),
                    label: Text("Record Video", style: TextStyle(color: Colors.white)),
                    onPressed: recordVideo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      minimumSize: Size(double.infinity, 60),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.attach_file, color: Colors.white),
                    label: Text("Select File", style: TextStyle(color: Colors.white)),
                    onPressed: selectFiles,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      minimumSize: Size(double.infinity, 60),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Submit button
            ElevatedButton.icon(
              icon: Icon(Icons.upload, color: Colors.white),
              label: Text("Submit", style: TextStyle(color: Colors.white)),
              onPressed: _isFileUploaded ? uploadFiles : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Green background
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                minimumSize: Size(double.infinity, 60), // Increased button height
              ),
            ),
          ],
        ),
      ),
    );
  }
}
