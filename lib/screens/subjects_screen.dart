import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/screens/material_screen.dart';



class SubjectsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> subjects;

  const SubjectsScreen({super.key, required this.subjects});

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> subjects = [
    {
      'name': 'Math',
      'icon': Icons.calculate,
      'color': Colors.red[300],
      'materials': [
        {'type': 'Documents', 'title': 'Math Chapter 1', 'url': 'https://example.com/math_ch1.pdf'},
        {'type': 'Notes', 'title': 'Math Handwritten Notes', 'content': 'This is a note about Math Chapter 1.'},
      ],
    },
    {
      'name': 'Chemistry',
      'icon': Icons.science,
      'color': Colors.purple[200],
      'materials': [
        {'type': 'Links', 'title': 'Chemistry Resource Link', 'url': 'https://example.com/chemistry_resource'},
        {'type': 'Notes', 'title': 'Chemistry Notes', 'content': 'Chemistry notes for the first chapter.'},
      ],
    },
    {
      'name': 'Physics',
      'icon': Icons.area_chart_rounded,
      'color': Colors.orange,
      'materials': [
        {'type': 'Documents', 'title': 'Physics Chapter 1', 'url': 'https://example.com/physics_ch1.pdf'},
        {'type': 'Videos', 'title': 'Physics Lecture 1', 'url': 'https://example.com/physics_lecture_1.mp4'},
      ],
    },
    {
      'name': 'Biology',
      'icon': Icons.local_florist,
      'color': Colors.green[300],
      'materials': [
        {'type': 'Videos', 'title': 'Biology Lecture 1', 'url': 'https://example.com/biology_lecture_1.mp4'},
        {'type': 'Notes', 'title': 'Biology Notes', 'content': 'Notes on Biology Chapter 1.'},
      ],
    },
    {
      'name': 'History',
      'icon': Icons.menu_book,
      'color': Colors.grey,
      'materials': [
        {'type': 'Documents', 'title': 'History Chapter 1', 'url': 'https://example.com/history_ch1.pdf'},
        {'type': 'Links', 'title': 'History Resource Link', 'url': 'https://example.com/history_resource'},
      ],
    },
    {
      'name': 'English',
      'icon': Icons.language,
      'color': Colors.blueGrey,
      'materials': [
        {'type': 'Videos', 'title': 'English Lecture 1', 'url': 'https://example.com/english_lecture_1.mp4'},
        {'type': 'Links', 'title': 'English Resource Link', 'url': 'https://example.com/english_resource'},
      ],
    },

  {
      'name': 'Arabic',
      'icon': Icons.create_outlined,
      'color': Colors.blue[300],
      'materials': [],
    },
  ];

  List<Map<String, dynamic>> filteredSubjects = [];
  bool isSearching = false;

  Map<String, bool> filters = {
    'Documents': false,
    'Videos': false,
    'Links': false,
    'Notes': false,
  };

  late Map<String, bool> tempFilters;

  @override
  void initState() {
    super.initState();
    filteredSubjects = List.from(widget.subjects);
    tempFilters = Map.from(filters);
  }

  void _applyFilters() {
    setState(() {
      filteredSubjects = List.from(subjects);
      filters = Map.from(tempFilters);
      if (filters.values.any((value) => value)) {
        filteredSubjects = filteredSubjects.where((subject) {
          List<Map<String, dynamic>> subjectMaterials =
              (subject['materials'] as List?)?.cast<Map<String, dynamic>>() ?? [];
          return filters.entries.any((filter) =>
          filter.value &&
              subjectMaterials.any((material) => material['type'] == filter.key));
        }).toList();
      }
    });
  }

  void _filterSubjects(String query) {
    setState(() {
      filteredSubjects = subjects
          .where((subject) =>
          subject['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      _applyFilters();
    });
  }

  // دالة لتحويل أو معالجة قيم الألوان
  Color _parseColor(dynamic color) {
    if (color is Color) {
      return color;
    } else if (color is String) {
      try {
        final hexCode = color.replaceAll('#', '');
        return Color(int.parse('FF$hexCode', radix: 16));
      } catch (e) {
        return Colors.blue; // لون افتراضي
      }
    }
    return Colors.blue; // لون افتراضي
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: isSearching
            ? TextField(
          controller: _searchController,
          onChanged: _filterSubjects,
          decoration: const InputDecoration(
            hintText: 'Search ...',
            border: InputBorder.none,
          ),
        )
            : const Text(
          'My Subjects',
          style:
          TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.white),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) _searchController.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.white),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: filteredSubjects.length,
          itemBuilder: (context, index) {
            final subject = filteredSubjects[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaterialScreen(
                        subjectName: subject['name'],
                        appBarColor: _parseColor(subject['color']), // استخدام الدالة هنا
                        materials: (subject['materials'] as List?)?.cast<Map<String, dynamic>>() ?? [],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: subject['color'],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        subject['icon'],
                        size: 50,
                        color: _getContrastColor(subject['color']),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        subject['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _getContrastColor(subject['color']),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getContrastColor(Color? backgroundColor) {
    final bg = backgroundColor ?? Colors.white;
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (dialogContext, setStateInsideDialog) {
            return AlertDialog(
              title: const Text('Filter Subjects'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: const Text('Select All'),
                    value: tempFilters.values.every((value) => value),
                    onChanged: (bool? value) {
                      setStateInsideDialog(() {
                        tempFilters.updateAll((key, val) => value ?? false);
                      });
                    },
                  ),
                  ...tempFilters.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: tempFilters[key]!,
                      onChanged: (bool? value) {
                        setStateInsideDialog(() {
                          tempFilters[key] = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _applyFilters();
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Apply'),
                ),
                TextButton(
                  onPressed: () {
                    setStateInsideDialog(() {
                      tempFilters = Map.from(filters);
                    });
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}