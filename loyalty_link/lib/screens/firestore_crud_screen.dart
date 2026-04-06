import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCrudScreen extends StatefulWidget {
  const FirestoreCrudScreen({super.key});

  @override
  State<FirestoreCrudScreen> createState() => _FirestoreCrudScreenState();
}

class _FirestoreCrudScreenState extends State<FirestoreCrudScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final _collection = FirebaseFirestore.instance.collection('tasks');

  String? _editingId;
  bool _loading = false;

  /// ➕ Add or Update
  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final description = _descController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      _showMessage('All fields are required');
      return;
    }

    setState(() => _loading = true);

    try {
      if (_editingId == null) {
        // ➕ CREATE
        await _collection.add({
          'title': title,
          'description': description,
          'createdAt': Timestamp.now(),
          'isCompleted': false,
        });

        _showMessage('Task added');
      } else {
        // ✏️ UPDATE (safe partial update)
        await _collection.doc(_editingId).set({
          'title': title,
          'description': description,
          'updatedAt': Timestamp.now(),
        }, SetOptions(merge: true));

        _showMessage('Task updated');
      }

      _clearFields();
    } catch (e) {
      _showMessage('Operation failed');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// 📝 Load data into form for editing
  void _editRecord(String id, Map<String, dynamic> data) {
    _titleController.text = data['title'] ?? '';
    _descController.text = data['description'] ?? '';

    setState(() {
      _editingId = id;
    });
  }

  /// 🧹 Reset form
  void _clearFields() {
    _titleController.clear();
    _descController.clear();
    _editingId = null;
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stream = _collection.orderBy('createdAt', descending: true).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore CRUD'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── FORM ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    child: _loading
                        ? const CircularProgressIndicator()
                        : Text(_editingId == null ? 'Add Task' : 'Update Task'),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // ── LIST ──
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                }

                final docs = snapshot.data?.docs ?? [];

                if (docs.isEmpty) {
                  return const Center(child: Text('No tasks found'));
                }

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final title = data['title'] ?? 'Untitled';
                    final desc = data['description'] ?? '';

                    return ListTile(
                      title: Text(title),
                      subtitle: Text(desc),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editRecord(doc.id, data),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}