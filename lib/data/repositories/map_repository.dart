// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_naver_map/flutter_naver_map.dart';

// class MapRepository {
//   Future<NLatLng?> getCoordsFromKakao(String keyword) async {
//     final encoded = Uri.encodeComponent(keyword);
//     final url = Uri.parse('https://dapi.kakao.com/v2/local/search/keyword.json?query=$encoded');

//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'KakaoAK [여기에_너의_API_KEY]',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final documents = data['documents'];
//       if (documents != null && documents.isNotEmpty) {
//         final first = documents[0];
//         final lat = double.parse(first['y']);
//         final lng = double.parse(first['x']);
//         return NLatLng(lat, lng);
//       }
//     }
//     return null;
//   }
// }
