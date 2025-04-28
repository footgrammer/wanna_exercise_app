import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController locationAddressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  String? selectedType;
  DateTime? timeFrom;
  DateTime? timeTo;

  final List<String> sports = ['축구', '풋살', '농구', '러닝'];


  Future<void> pickDateTime(bool isStart) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final picked = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isStart) {
        timeFrom = picked;
      } else {
        timeTo = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '게시물 작성',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: '운동 종류',
                border: OutlineInputBorder(),
              ),
              items: sports.map((sport) {
                return DropdownMenuItem(value: sport, child: Text(sport));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => pickDateTime(true),
              child: Text(
                timeFrom == null
                    ? '시작 시간 : 시작시간 선택'
                    : '시작 시간 : ${timeFrom.toString().split('.')[0]}',
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => pickDateTime(false),
              child: Text(
                timeTo == null
                    ? '종료 시간 : 종료시간 선택'
                    : '종료 시간 : ${timeTo.toString().split('.')[0]}',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: '장소명',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationAddressController,
              decoration: const InputDecoration(
                labelText: '상세 주소',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '모집 인원',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedType == null ||
                      titleController.text.isEmpty ||
                      contentController.text.isEmpty ||
                      locationController.text.isEmpty ||
                      locationAddressController.text.isEmpty ||
                      numberController.text.isEmpty ||
                      timeFrom == null ||
                      timeTo == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('모든 항목을 입력하세요')),
                    );
                    return;
                  }

                  final result = {
                    'type': selectedType,
                    'title': titleController.text,
                    'content': contentController.text,
                    'timeFrom': timeFrom.toString(),
                    'timeTo': timeTo.toString(),
                    'location': locationController.text,
                    'locationAddress': locationAddressController.text,
                    'number': numberController.text,
                  };

                  Navigator.pop(context, result);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('작성 완료'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
