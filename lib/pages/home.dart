import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tp/services/firebase.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Code'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firebaseService.getCodes(),
        builder: (context, snapshot) {
          print('StreamBuilder state: ${snapshot.connectionState}');
          if (snapshot.hasError) {
            print('Error in StreamBuilder: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Waiting for data...');
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print('No data available');
            return const Center(child: Text('No codes found'));
          }

          print('Data received: ${snapshot.data!.docs.length} documents');
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return CodeItem(code: data['code'] ?? 'No code');
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCodeDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newCode = '';
        return AlertDialog(
          title: const Text('Add New Code'),
          content: TextField(
            onChanged: (value) {
              newCode = value;
            },
            decoration: const InputDecoration(hintText: "Enter your code"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () async {
                if (newCode.isNotEmpty) {
                  try {
                    await _firebaseService.createCode(newCode);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Code added successfully')),
                    );
                  } catch (e) {
                    print('Error adding code: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error adding code: $e')),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class CodeItem extends StatelessWidget {
  final String code;

  const CodeItem({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}