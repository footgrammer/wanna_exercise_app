import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:wanna_exercise_app/data/models/board.dart';
import 'package:wanna_exercise_app/utils/kakao_location_helper.dart';
import 'package:geolocator/geolocator.dart';

class MapViewModel {
  late NaverMapController mapController;// 지도 조작할 때 사용할 컨트롤러
  List<Board> boards = [];// Firestore에서 불러온 모임(Board) 리스트

/// Firestore에서 boards 데이터 불러오기
  Future<void> loadBoards() async {
    final snapshot = await FirebaseFirestore.instance.collection('boards').get();
    boards = snapshot.docs.map((doc) => Board.fromJson(doc.data())).toList();
  }


  /// boards 리스트를 지도에 마커로 표시
  Future<void> addMarkers(Function(Board) onMarkerTap) async {
    mapController.clearOverlays();

    for (final board in boards) {
       // 카카오맵 API를 사용해 주소 -> 좌표 변환
      final coords = await KakaoLocationHelper.getCoordsFromAddress(board.locationAddress);
      if (coords == null) continue; // 좌표 변환 실패하면 스킵

      final marker = NMarker(id: board.title, position: coords);
      // 마커 클릭했을 때 동작 (콜백으로 넘긴 onMarkerTap 호출)
      marker.setOnTapListener((_) {
        onMarkerTap(board);
      });

      mapController.addOverlay(marker);// 지도에 마커 추가
    }
  }
  /// 현재 내 위치로 지도 이동
  Future<void> moveToCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;// 권한 거부 시 리턴

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final current = NLatLng(position.latitude, position.longitude);

    mapController.updateCamera(NCameraUpdate.scrollAndZoomTo(target: current, zoom: 13));
  }
  /// 검색한 지역으로 지도 이동
  Future<void> searchAndShowRegion(String keyword) async {
    final coords = await KakaoLocationHelper.getCoordsFromAddress(keyword);
    if (coords == null) return;// 검색 실패 시 리턴

    mapController.updateCamera(NCameraUpdate.scrollAndZoomTo(target: coords, zoom: 13));
  }
}
