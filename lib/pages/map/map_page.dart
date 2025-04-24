import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:wanna_exercise_app/pages/map/widgets/event_card_widget.dart';
import 'package:wanna_exercise_app/pages/map/widgets/search_bar_widget.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late NaverMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: NaverMap(
              onMapReady: (controller) {
                _mapController = controller;

                final marker = NMarker(
                  id: 'marker1',
                  position: const NLatLng(37.5665, 126.9780),
                );

                _mapController.addOverlay(marker);

                marker.setOnTapListener((_) {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('서울시청 근처 운동 소모임!'),
                    ),
                  );
                });
              },
              options: const NaverMapViewOptions(
                locationButtonEnable: true,
                zoomGesturesEnable: true,
              ),
            ),
          ),
          const Positioned(top: 50, left: 16, right: 16, child: SearchBarWidget()),
          const Positioned(bottom: 16, left: 0, right: 0, child: EventCardWidget()),
        ],
      ),
    );
  }
}
