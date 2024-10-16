import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Announcements extends StatefulWidget {
  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<Announcements> {
  List<dynamic> _assignments = [];
  late Timer _timer;
  int _lastAssignmentCount = 0; // Store the previous number of assignments

  @override
  void initState() {
    super.initState();
    // Start polling every 30 seconds
    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) => _checkForNewAssignments());
    _fetchAssignments(); // Fetch the initial list of assignments
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Fetch all assignments from the backend
  Future<void> _fetchAssignments() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/assign/view/'));
    if (response.statusCode == 200) {
      setState(() {
        _assignments = json.decode(response.body);
        _lastAssignmentCount = _assignments.length; // Store the current number of assignments
      });
    } else {
      print("Failed to load assignments.");
    }
  }

  // Check for new assignments by polling the backend
  Future<void> _checkForNewAssignments() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/create'));
    if (response.statusCode == 200) {
      List<dynamic> fetchedAssignments = json.decode(response.body);
      if (fetchedAssignments.length > _lastAssignmentCount) {
        // New assignment detected
        _showNotification("New assignment created!");
        setState(() {
          _assignments = fetchedAssignments;
          _lastAssignmentCount = fetchedAssignments.length; // Update the count
        });
      }
    } else {
      print("Failed to check for new assignments.");
    }
  }

  // Function to show a notification in the app
  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcements"),
        backgroundColor: Colors.blue[900], // Darker blue for the app bar
      ),
      body: ListView.builder(
        itemCount: _assignments.length,
        itemBuilder: (context, index) {
          final assignment = _assignments[index];
          return ListTile(
            title: Text(assignment['title']),
            subtitle: Text("Due date: ${assignment['due_date']}"),
          );
        },
      ),
    );
  }
}
