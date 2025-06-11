import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bahga_student/screens/note_view_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../models/subject_model.dart';

class TopicScreen extends StatelessWidget {
  final String lessonTitle;
  final List<Topic> topics;
  final Color barColor;

  const TopicScreen({
    Key? key,
    required this.lessonTitle,
    required this.topics,
    required this.barColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lessonTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        backgroundColor: barColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: topics.isEmpty
          ? const Center(
        child: Text(
          'No topics available.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: _getTopicIcon(topic.type),
              title: Text(topic.title),
              subtitle: Text(topic.type),
              onTap: () {
                _handleTopicTap(context, topic);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getTopicIcon(String type) {
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

  void _handleTopicTap(BuildContext context, Topic topic) {
    final type = topic.type;
    final url = topic.url;
    final content = topic.content;

    if (type == 'Notes') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NoteViewScreen(
            title: topic.title,
            content: content.isNotEmpty ? content : 'No content available.',
          ),
        ),
      );
    } else if (url.isNotEmpty) {
      _showOpenOptionsDialog(context, url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No valid URL found')),
      );
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