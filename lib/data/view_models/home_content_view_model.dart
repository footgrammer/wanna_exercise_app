import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeContentViewModel {
  String currentAddress = '위치 가져오는 중...';

  Future<void> getCurrentLocation(Function(String) onAddressUpdated) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        onAddressUpdated('위치 권한이 필요합니다');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = '${place.locality ?? ''} ${place.subLocality ?? ''}';
        onAddressUpdated(address);
      }
    } catch (e) {
      print('위치 가져오기 에러: $e');
      onAddressUpdated('위치 가져오기 실패');
    }
  }
}
