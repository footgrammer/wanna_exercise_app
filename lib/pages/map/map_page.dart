// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:wanna_exercise_app/data/view_models/map_view_model.dart';
// import 'widgets/event_card_widget.dart';
// import 'widgets/search_bar_widget.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   final MapViewModel viewModel = MapViewModel();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: NaverMap(
//               onMapReady: (controller) {
//                 viewModel.mapController = controller;

//                 viewModel.loadDummyMarkers((marker, post) {
//                   marker.setOnTapListener((_) {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (_) => EventCardWidget(
//                         title: post.title,
//                         time: post.startTime,
//                       ),
//                     );
//                   });
//                   controller.addOverlay(marker);
//                 });
//               },
//               options: const NaverMapViewOptions(
//                 locationButtonEnable: true,
//                 zoomGesturesEnable: true,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 50,
//             left: 16,
//             right: 16,
//             child: SearchBarWidget(
//               onSearch: (keyword) {
//                 viewModel.moveToLocationAndFilterMarkers(
//                   keyword: keyword,
//                   onMarkerReady: (marker, post) {
//                     marker.setOnTapListener((_) {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (_) => EventCardWidget(
//                           title: post.title,
//                           time: post.startTime,
//                         ),
//                       );
//                     });
//                     viewModel.mapController.addOverlay(marker);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'package:wanna_exercise_app/pages/map/widgets/event_card_widget.dart';
import 'package:wanna_exercise_app/pages/map/widgets/search_bar_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // TODO: Firebase 준비되면 주석 해제

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late NaverMapController _mapController;

  // 🔹 더미 데이터
  final List<Map<String, String>> dummyPosts = [
    {
      'location': '서울 강남역',
      'title': '강남역 러닝 모임',
      'startTime': '오늘 오후 6시',
    },
    {
      'location': '해운대 해수욕장',
      'title': '부산 조깅 팀',
      'startTime': '내일 오전 7시',
    },
    {
      'location': '전주 한옥마을',
      'title': '전주 산책 모임',
      'startTime': '이번 주말 오후 3시',
    },
  ];

  Future<NLatLng?> getCoordsFromKakao(String keyword) async {
    final encoded = Uri.encodeComponent(keyword);
    final url = Uri.parse('https://dapi.kakao.com/v2/local/search/keyword.json?query=$encoded');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'KakaoAK 791070265eff4f73e8343ac2f4dc34dc',
      },
    );

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

  Future<void> loadAndMarkFromDummy() async {
    for (final post in dummyPosts) {
      final address = post['location']!;
      final coords = await getCoordsFromKakao(address);

      if (coords != null) {
        final marker = NMarker(id: address, position: coords);

        marker.setOnTapListener((_) {
          showModalBottomSheet(
            context: context,
            builder: (_) => EventCardWidget(
              title: post['title'] ?? '제목 없음',
              time: post['startTime'] ?? '시간 미정',
            ),
          );
        });

        _mapController.addOverlay(marker);
      }
    }
  }

  Future<void> searchAndShowRegion(String keyword) async {
    final center = await getCoordsFromKakao(keyword);
    if (center == null) return;

    _mapController.updateCamera(NCameraUpdate.scrollAndZoomTo(target: center, zoom: 13));
    _mapController.clearOverlays();

    // TODO: 파이어베이스 연동 전까지는 더미에서 필터
    for (final post in dummyPosts) {
      final address = post['location']!;
      final coords = await getCoordsFromKakao(address);

      if (coords != null && isNearby(center, coords)) {
        final marker = NMarker(id: address, position: coords);

        marker.setOnTapListener((_) {
          showModalBottomSheet(
            context: context,
            builder: (_) => EventCardWidget(
              title: post['title'] ?? '제목 없음',
              time: post['startTime'] ?? '시간 미정',
            ),
          );
        });

        _mapController.addOverlay(marker);
      }
    }
  }

  bool isNearby(NLatLng a, NLatLng b, {double maxMeters = 3000}) {
    return a.distanceTo(b) <= maxMeters;
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
                loadAndMarkFromDummy(); // ✅ 더미 데이터 마커 표시
              },
              options: const NaverMapViewOptions(
                locationButtonEnable: true,
                zoomGesturesEnable: true,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: SearchBarWidget(onSearch: searchAndShowRegion),
          ),
        ],
      ),
    );
  }
}
