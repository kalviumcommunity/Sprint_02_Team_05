import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RealtimePostsScreen extends StatelessWidget {
  const RealtimePostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postsStream =
        FirebaseFirestore.instance.collection('posts').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Posts'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: postsStream,
        builder: (context, snapshot) {
          // ⏳ Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error state
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading posts'));
          }

          final docs = snapshot.data?.docs ?? [];

          // 📭 Empty state
          if (docs.isEmpty) {
            return const Center(child: Text('No posts yet'));
          }

          // ✅ Real-time list
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              final title = data['title'] ?? 'Untitled';
              final content = data['content'] ?? 'No content';

              return _PostCard(
                title: title,
                content: content,
              );
            },
          );
        },
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String title;
  final String content;

  const _PostCard({
    required this.title,
    required this.content,
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
              content,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}