import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressSearchPage extends StatefulWidget {
  const AddressSearchPage({Key? key}) : super(key: key);

  @override
  State<AddressSearchPage> createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];
  bool _isLoading = false;

  final String clientId = 'c66vpfXUqZhS7nJNDTvI';
  final String clientSecret = '3uHP4Z2T1X';

  Future<void> searchAddress(String keyword) async {
    if (keyword.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    final encoded = Uri.encodeComponent(keyword.trim());
    final url = Uri.parse('https://openapi.naver.com/v1/search/local.json?query=$encoded');

    final response = await http.get(
      url,
      headers: {
        'X-Naver-Client-Id': clientId,
        'X-Naver-Client-Secret': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List items = data['items'] ?? [];

      setState(() {
        _searchResults = items.map<Map<String, String>>((item) {
          return {
            'location': (item['title'] ?? '').replaceAll(RegExp(r'<[^>]*>'), ''),
            'locationAddress': item['roadAddress'] ?? item['address'] ?? '',
          };
        }).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('네이버 장소 검색 실패: ${response.statusCode}')),
      );
      print('네이버 장소 검색 실패: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주소 검색'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '검색할 장소를 입력하세요',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchAddress(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                searchAddress(value);
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                    ? const Center(child: Text('검색 결과가 없습니다'))
                    : ListView.separated(
                        itemCount: _searchResults.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final item = _searchResults[index];
                          return ListTile(
                            title: Text(item['location']!),
                            subtitle: Text(item['locationAddress']!),
                            onTap: () {
                              Navigator.pop(context, item);
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
