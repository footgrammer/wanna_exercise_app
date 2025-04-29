import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:wanna_exercise_app/pages/map/widgets/event_card_widget.dart';
import 'package:wanna_exercise_app/pages/map/widgets/search_bar_widget.dart';
import 'package:wanna_exercise_app/data/view_models/map_view_model.dart';
import 'package:wanna_exercise_app/data/models/board.dart';

class MapPage extends StatefulWidget {
  final String myUserId;//로그인한 내 유저ID

  const MapPage({super.key, required this.myUserId});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapViewModel viewModel = MapViewModel();// 지도 관련 로직을 담당하는 ViewModel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 네이버 지도 표시
          Positioned.fill(
            child: NaverMap(
              onMapReady: (controller) async {
                // 지도 준비 완료되면
                viewModel.mapController = controller;
                // Firestore에서 boards 불러오기
                await viewModel.loadBoards();
                // boards 데이터 기반으로 지도에 마커 추가
                await viewModel.addMarkers((Board board) {
                  // 마커 클릭 시, 모달 띄워서 게시글 정보 보여주기
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => EventCardWidget(
                      title: board.title,
                      content: board.content,
                      time: '${board.timeFrom}:00 ~ ${board.timeTo}:00',
                      myUserId: widget.myUserId,// 모달에서도 myUserId 넘겨줌
                    ),
                  );
                });
              },
              options: const NaverMapViewOptions(
                locationButtonEnable: true,// 내 위치 버튼 보이게 설정
                zoomGesturesEnable: true,// 핀치줌 허용
              ),
            ),
          ),
          // 검색창 (상단에 위치)
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: SearchBarWidget(
              // 검색창에 키워드 입력 후 검색
              onSearch: (keyword) async {
                await viewModel.searchAndShowRegion(keyword);
              },
              // 현재 위치 버튼 클릭
              onCurrentLocationPressed: () async {
                await viewModel.moveToCurrentLocation();
              },
            ),
          ),
        ],
      ),
    );
  }
}