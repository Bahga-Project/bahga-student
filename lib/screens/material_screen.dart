import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bahga_student/screens/note_view_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class MaterialScreen extends StatelessWidget {
  final String subjectName;
  final Color appBarColor;
  final List<Map<String, dynamic>> materials;

  const MaterialScreen({
    Key? key,
    required this.subjectName,
    required this.appBarColor,
    required this.materials,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectName,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: materials.isEmpty
          ? const Center(
        child: Text(
          'No materials available.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final material = materials[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: _getMaterialIcon(material['type']),
              title: Text(material['title'] ?? ''),
              subtitle: Text(material['type']),
              onTap: () {
                final type = material['type'];
                final url = material['url'];

                if (type == 'Notes') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteViewScreen(
                        title: material['title'] ?? 'Note',
                        content: material['content'] ?? 'No content available.',
                      ),
                    ),
                  );
                } else if (url != null && url is String) {
                  _showOpenOptionsDialog(context, url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No valid URL found')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getMaterialIcon(String type) {
    switch (type) {
      case 'Documents':
        return const Icon(Icons.picture_as_pdf, color: Colors.red);
      case 'Videos':
        return const Icon(Icons.play_circle_fill, color: Colors.blue);
      case 'Links':
        return const Icon(Icons.link, color: Colors.green);
      case 'Notes':
        return const Icon(Icons.edit_note, color: Colors.orange);
      default:
        return const Icon(Icons.insert_drive_file);
    }
  }

  void _showOpenOptionsDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open with'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.open_in_browser),
                title: const Text('Open in Browser'),
                onTap: () {
                  _launchURL(url);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy),
                title: const Text('Download File'),
                onTap: () {
                  _downloadFile(url, context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.view_agenda),
                title: const Text('View in App'),
                onTap: () {
                  _viewInApp(url, context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void _downloadFile(String url, BuildContext context) async {
    try {

      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final fileName = url.split('/').last;
      final savePath = '${dir.path}/$fileName';
      await dio.download(url, savePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File downloaded to $savePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Download failed')),
      );
    }
  }

  void _viewInApp(String url, BuildContext context) {
    if (url.endsWith('.pdf')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PDFViewScreen(url: url),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot view this file in the app')),
      );
    }
  }
}

class PDFViewScreen extends StatelessWidget {
  final String url;

  const PDFViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View PDF'),
      ),
      body: PDFView(
        filePath: url,
      ),
    );
  }
}
