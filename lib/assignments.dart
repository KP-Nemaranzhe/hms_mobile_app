import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'assignment_details.dart'; // Import the AssignmentDetails page

class Assignments extends StatefulWidget {
  @override
  _AssignmentsState createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  List<dynamic> assignments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAssignments();
  }

  Future<void> fetchAssignments() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/assign/view/'));

      if (response.statusCode == 200) {
        setState(() {
          assignments = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load assignments');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching assignments: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching assignments: $e')),
      );
    }
  }

  void navigateToDetails(dynamic assignment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignmentDetails(assignment: assignment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignments"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: assignments.isEmpty
            ? Center(
          child: Text(
            'No assignments available.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assignments List",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 16),
            // Move the table to the left
            Padding(
              padding: const EdgeInsets.only(left: 8.0), // Adjust left padding as needed
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all<Color>(
                    Colors.blue.shade100, // Use a light blue for heading
                  ),
                  columns: [
                    DataColumn(
                      label: Container(
                        width: 120, // Width for the Assignment Title column
                        child: Text(
                          'Assignment Title',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        width: 50, // Reduced width for the Status column
                        child: Text(
                          'Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        width: 50, // Reduced width for the Due Date column
                        child: Text(
                          'Due Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  rows: assignments.map<DataRow>((assignment) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: 120, // Width for the cell
                            child: Text(
                              assignment['title'],
                              style: TextStyle(fontSize: 16, color: Colors.blue), // Blue color for assignment title
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onTap: () => navigateToDetails(assignment), // Navigate on tap
                        ),
                        DataCell(
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: assignment['status'] == 'Completed'
                                  ? Colors.green.shade100
                                  : Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              assignment['status'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: assignment['status'] == 'Completed'
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            assignment['due_date'],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
