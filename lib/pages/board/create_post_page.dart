import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/board/address_search_page.dart';

class CreatePostPage extends StatefulWidget {
  final String? initialType; // ⭐ 운동 종류 초기값 받기

  const CreatePostPage({Key? key, this.initialType}) : super(key: key);

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
  DateTime? selectedDate;
  TimeOfDay? selectedTimeFrom;
  TimeOfDay? selectedTimeTo;

  final List<String> sports = ['축구', '풋살', '농구', '러닝'];

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType; // ⭐ 초기 선택값 설정
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> pickTime(bool isStart) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        if (isStart) {
          selectedTimeFrom = time;
        } else {
          selectedTimeTo = time;
        }
      });
    }
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
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
              value: selectedType, // ⭐ 초기값 적용
              decoration: const InputDecoration(
                labelText: '운동 종류',
                border: OutlineInputBorder(),
              ),
              items: sports.map((sport) {
                return DropdownMenuItem(
                  value: sport,
                  child: Text(sport),
                );
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
              onPressed: pickDate,
              child: Text(
                selectedDate == null
                    ? '날짜 선택'
                    : '선택된 날짜: ${formatDate(selectedDate!)}',
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => pickTime(true),
              child: Text(
                selectedTimeFrom == null
                    ? '시작 시간 선택'
                    : '시작 시간: ${formatTime(selectedTimeFrom!)}',
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => pickTime(false),
              child: Text(
                selectedTimeTo == null
                    ? '종료 시간 선택'
                    : '종료 시간: ${formatTime(selectedTimeTo!)}',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddressSearchPage()),
                );

                if (result != null) {
                  setState(() {
                    locationController.text = result['location'] ?? '';
                    locationAddressController.text = result['locationAddress'] ?? '';
                  });
                }
              },
              child: const Text('주소 검색하기'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: '선택된 장소명',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationAddressController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: '선택된 상세 주소',
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
                      selectedDate == null ||
                      selectedTimeFrom == null ||
                      selectedTimeTo == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('모든 항목을 입력하세요')),
                    );
                    return;
                  }

                  final result = {
                    'type': selectedType!,
                    'title': titleController.text,
                    'content': contentController.text,
                    'date': formatDate(selectedDate!),
                    'timeFrom': formatTime(selectedTimeFrom!),
                    'timeTo': formatTime(selectedTimeTo!),
                    'location': locationController.text,
                    'locationAddress': locationAddressController.text,
                    'number': int.parse(numberController.text),
                  };

                  Navigator.pop(context, result);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('작성 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
