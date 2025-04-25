// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import '../models/post_model.dart';
// import '../repositories/map_repository.dart';

// class MapViewModel extends ChangeNotifier {
//   final mapRepository = MapRepository();
//   late NaverMapController mapController;

//   List<PostModel> allPosts = [];

//   // 더미 데이터 
//   final List<PostModel> dummyPosts = [
//     PostModel(
//       location: '서울 강남역',
//       title: '강남 러닝 크루',
//       startTime: '오늘 오후 6시',
//     ),
//     PostModel(
//       location: '전주 한옥마을',
//       title: '전주 모임',
//       startTime: '내일 오후 3시',
//     ),
//     PostModel(
//       location: '해운대 해수욕장',
//       title: '부산 아침 조깅',
//       startTime: '이번 주말 오전 7시',
//     ),
//   ];

//   Future<void> loadDummyMarkers(Function(NMarker marker, PostModel post) onMarkerReady) async {
//     allPosts = dummyPosts;

//     for (final post in allPosts) {
//       final coords = await mapRepository.getCoordsFromKakao(post.location);
//       if (coords != null) {
//         final marker = NMarker(id: post.location, position: coords);
//         onMarkerReady(marker, post);
//       }
//     }
//   }

//   Future<void> moveToLocationAndFilterMarkers({
//     required String keyword,
//     required Function(NMarker marker, PostModel post) onMarkerReady,
//   }) async {
//     final center = await mapRepository.getCoordsFromKakao(keyword);
//     if (center == null) return;

//     mapController.updateCamera(
//       NCameraUpdate.scrollAndZoomTo(target: center, zoom: 13),
//     );
//     mapController.clearOverlays();

//     for (final post in allPosts) {
//       final coords = await mapRepository.getCoordsFromKakao(post.location);
//       if (coords != null && _isNearby(center, coords)) {
//         final marker = NMarker(id: post.location, position: coords);
//         onMarkerReady(marker, post);
//       }
//     }
//   }

//   bool _isNearby(NLatLng a, NLatLng b, {double maxMeters = 3000}) {
//     return a.distanceTo(b) <= maxMeters;
//   }
// }
