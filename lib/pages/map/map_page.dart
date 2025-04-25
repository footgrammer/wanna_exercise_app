import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'package:wanna_exercise_app/pages/map/widgets/event_card_widget.dart';
import 'package:wanna_exercise_app/pages/map/widgets/search_bar_widget.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late NaverMapController _mapController;

  Future<NLatLng?> getCoordsFromKakao(String keyword) async {
    final encoded = Uri.encodeComponent(keyword);
    final url = Uri.parse(
      'https://dapi.kakao.com/v2/local/search/keyword.json?query=$encoded',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'KakaoAK 791070265eff4f73e8343ac2f4dc34dc', 
      },
    );

    print('Kakao API 응답 코드: ${response.statusCode}');
    print('응답 내용: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final documents = data['documents'];
      if (documents != null && documents.isNotEmpty) {
        final first = documents[0];
        final lat = double.parse(first['y']);
        final lng = double.parse(first['x']);
        return NLatLng(lat, lng);
      }
    }
    return null;
  }

  /// 더미 주소로 마커 찍기
  Future<void> loadAndMarkAddresses() async {
    final List<String> dummyAddresses = [
      '서울디지털산업단지 인조잔디축구장',
      '서울특별시 중구 세종대로 110',
      '부산 해운대 해수욕장',
      '대구 반월당역',
      '광주 유스퀘어 터미널',
    ];

    for (final address in dummyAddresses) {
      print('장소 검색 시도: $address');
      final coords = await getCoordsFromKakao(address);
      if (coords != null) {
        print('좌표 변환 성공: $coords');
        final marker = NMarker(id: address, position: coords);

        marker.setOnTapListener((_) {
          showModalBottomSheet(
            context: context,
            builder: (_) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text('장소: $address'),
            ),
          );
        });

        _mapController.addOverlay(marker);
      } else {
        print('좌표 변환 실패: $address');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: NaverMap(
              onMapReady: (controller) {
                _mapController = controller;
                loadAndMarkAddresses(); 
              },
              options: const NaverMapViewOptions(
                locationButtonEnable: true,
                zoomGesturesEnable: true,
              ),
            ),
          ),
          const Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: SearchBarWidget(),
          ),
          const Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: EventCardWidget(),
          ),
        ],
      ),
    );
  }
}
