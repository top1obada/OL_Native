import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ol_driving_license_management_dto/VisionTestRequestDTO/VisionTestResult.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/FilesProviders/vision_text_result_file_upload_provider.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:provider/provider.dart';

class UIUploadVisionTestResult extends StatefulWidget {
  const UIUploadVisionTestResult({super.key});

  @override
  State<UIUploadVisionTestResult> createState() =>
      _UIUploadVisionTestResultState();
}

class _UIUploadVisionTestResultState extends State<UIUploadVisionTestResult> {
  File? selectedFile;

  Future<void> pickPDF() async {
    if (context.read<PVVisionTestResultFileUpload>().isLoading) {
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ No file selected.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Please select a PDF file first!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final provider = context.read<PVVisionTestResultFileUpload>();

    provider.visionTestResultFile = selectedFile;

    await provider.uploadFile();

    if (provider.isUploaded == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Vision test uploaded successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      if (!mounted) return;
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Upload failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<PVVisionTestResultFileUpload>().userID =
          context
              .read<PVBaseCurrentLogin>()
              .currentLoginInformationDTO!
              .userID!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;

    final isDesktop = screenWidth > 600;

    return BaseScaffold(
      title: 'Vision Test Uploading',
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 500 : double.infinity,
          ),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:
                    isDark
                        ? Colors.black54
                        : Colors.grey.withAlpha((0.3 * 255).round()),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.upload_file,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Upload your vision test result as a PDF file.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: pickPDF,
                icon: const Icon(Icons.file_open),
                label: const Text('Select PDF File'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
              const SizedBox(height: 15),
              if (selectedFile != null)
                Text(
                  '📄 Selected: ${selectedFile!.path.split('/').last}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              if (selectedFile == null)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'No file selected yet.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

              const SizedBox(height: 30),

              Consumer<PVVisionTestResultFileUpload>(
                builder:
                    (context, value, child) =>
                        value.isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                              onPressed: uploadFile,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                              ),
                              child: const Text('Upload'),
                            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
