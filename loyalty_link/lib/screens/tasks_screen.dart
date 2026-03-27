import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksStream =
        FirebaseFirestore.instance.collection('tasks').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Dashboard'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: tasksStream,
        builder: (context, snapshot) {
          // ⏳ Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          // 📭 Empty state
          if (docs.isEmpty) {
            return const Center(
              child: Text('No tasks available'),
            );
          }

          // ✅ Data display
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              final title = data['title'] ?? 'Untitled';
              final description = data['description'] ?? 'No description';

              return _TaskCard(
                title: title,
                description: description,
              );
            },
          );
        },
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String title;
  final String description;

  const _TaskCard({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}