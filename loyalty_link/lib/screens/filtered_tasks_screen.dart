import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilteredTasksScreen extends StatelessWidget {
  const FilteredTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🎯 Query: incomplete tasks, sorted by priority, limited results
    final query = FirebaseFirestore.instance
        .collection('tasks')
        .where('isCompleted', isEqualTo: false)
        .orderBy('priority')
        .limit(20)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Tasks'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: query,
        builder: (context, snapshot) {
          // ⏳ Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading tasks'));
          }

          final docs = snapshot.data?.docs ?? [];

          // 📭 Empty
          if (docs.isEmpty) {
            return const Center(child: Text('No pending tasks'));
          }

          // ✅ Display
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              final title = data['title'] ?? 'Untitled';
              final priority = data['priority'] ?? 0;

              return _TaskTile(
                title: title,
                priority: priority,
              );
            },
          );
        },
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final String title;
  final int priority;

  const _TaskTile({
    required this.title,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(priority.toString()),
        ),
        title: Text(title),
        subtitle: Text('Priority: $priority'),
      ),
    );
  }
}