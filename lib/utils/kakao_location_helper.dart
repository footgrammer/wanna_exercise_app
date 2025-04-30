import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_naver_map/flutter_naver_map.dart';

class KakaoLocationHelper {
  // Kakao REST API Key
  static const _kakaoApiKey = 'KakaoAK [내KEY]'; 

  // 주소(문자열)를 받아서 좌표(NLatLng)로 변환하는 함수
  static Future<NLatLng?> getCoordsFromAddress(String address) async {
    final encoded = Uri.encodeComponent(address);// 주소를 URL 인코딩
    final url = Uri.parse(
      'https://dapi.kakao.com/v2/local/search/keyword.json?query=$encoded',
    );
    // Kakao REST API 호출 (GET 요청)
    final response = await http.get(
      url,
      headers: {'Authorization': _kakaoApiKey},
    );
    // API 호출 성공했을 때 (상태코드 200)
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
    // 실패하거나 결과 없으면 null 반환
    return null;
  }
}
