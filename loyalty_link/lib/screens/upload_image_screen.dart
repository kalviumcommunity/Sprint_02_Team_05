import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  String? _imageUrl;
  bool _loading = false;

  /// 📸 Pick Image
  Future<void> _pickImage() async {
    final XFile? file =
        await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _selectedImage = File(file.path);
      });
    }
  }

  /// ☁️ Upload to Firebase Storage
  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      _showMessage('Please select an image first');
      return;
    }

    setState(() => _loading = true);

    try {
      final fileName =
          DateTime.now().millisecondsSinceEpoch.toString();

      final ref =
          FirebaseStorage.instance.ref('uploads/$fileName.jpg');

      await ref.putFile(_selectedImage!);

      final url = await ref.getDownloadURL();

      setState(() {
        _imageUrl = url;
      });

      _showMessage('Upload successful');
    } catch (e) {
      _showMessage('Upload failed');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 📷 Preview (local)
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 150,
              ),

            const SizedBox(height: 20),

            // ☁️ Uploaded Image
            if (_imageUrl != null)
              Image.network(
                _imageUrl!,
                height: 150,
              ),

            const SizedBox(height: 20),

            // 📸 Pick Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
            ),

            const SizedBox(height: 10),

            // 🚀 Upload Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _uploadImage,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}