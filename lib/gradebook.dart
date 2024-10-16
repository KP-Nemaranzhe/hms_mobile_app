import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // Import for JSON encoding/decoding

class Gradebook extends StatefulWidget {
  @override
  _GradebookState createState() => _GradebookState();
}

class _GradebookState extends State<Gradebook> {
  List<dynamic> grades = []; // List to store grades
  bool isLoading = true; // To show loading indicator

  @override
  void initState() {
    super.initState();
    fetchGrades(); // Fetch grades when the widget is initialized
  }

  // Function to fetch grades from the API
  Future<void> fetchGrades() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/grades/'));

      if (response.statusCode == 200) {
        // Decode the JSON response
        setState(() {
          grades = json.decode(response.body); // Assuming the API returns a list of grades
          isLoading = false; // Set loading to false once data is fetched
        });
      } else {
        // Handle error response
        setState(() {
          isLoading = false; // Stop loading if there's an error
        });
        print('Failed to load grades: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions
      setState(() {
        isLoading = false; // Stop loading on error
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gradebook"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : grades.isEmpty
          ? Center(child: Text("No grades found.")) // Message if no grades
          : SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text("Assignment")),
            DataColumn(label: Text("Grade")),
          ],
          rows: grades.map<DataRow>((grade) {
            return DataRow(
              cells: [
                DataCell(Text(grade['assignment_name'] ?? 'N/A')), // Replace with actual field from your model
                DataCell(Text((grade['grade'] ?? 'N/A').toString())), // Ensure conversion to string
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
