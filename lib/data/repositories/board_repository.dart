import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/data/models/board.dart';

class BoardRepository {
  // 서버와 통신할 때에는 항상 비동기!
  Future<List<Board>?> getBoardsData() async {
    try {
      // 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;

      // 컬렉션 참조 만들기
      final collectionRef = firestore.collection('boards');

      // 값 불러오기
      final result = await collectionRef.get();
      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        final newMap = {...map, 'boardId': doc.id};
        // ...map이 되에 오면 map 안에 boardId 값이 덮어쓸 수 있기 때문에 순서 바꿔주기
        return Board.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 1. create
  Future<bool> createBoard({
    required String type,
    required String title,
    required String content,
    required DateTime date,
    required int timeFrom,
    required int timeTo,
    required String location,
    required String locationAddress,
    required int number,
  }) async {
    try {
      //1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      //2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('boards');

      // 3. 문서 참조 만들기
      final docRef = collectionRef.doc();

      // 4. 값 쓰기
      await docRef.set({
        'type': type,
        'title': title,
        'content': content,
        'date': date.toIso8601String(),
        'timeFrom': timeFrom,
        'timeTo': timeTo,
        'location': location,
        'locationAddress': locationAddress,
        'number': number,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // 2. Read : 특정 ID로 하나의 도큐먼트 가져오기
  Future<Board?> getBoard(String boardId) async {
    try {
      //1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      //2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('boards');

      // 3. 문서 참조 만들기
      final docRef = collectionRef.doc(boardId);

      // 4. 데이터 가져오기
      final doc = await docRef.get();
      return Board.fromJson({'boardId': doc.id, ...doc.data()!});
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 3. update
  Future<bool> updateBoard({
    required String boardId,
    required String type,
    required String title,
    required String content,
    required DateTime date,
    required int timeFrom,
    required int timeTo,
    required String location,
    required String locationAddress,
    required int number,
  }) async {
    try {
      //1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      //2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('boards');

      // 3. 문서 참조 만들기
      final docRef = collectionRef.doc(boardId);

      // 4. 데이터 업데이트 해주기 (set 혹은 update)
      await docRef.update({
        'type': type,
        'title': title,
        'content': content,
        'date': date.toIso8601String(),
        'timeFrom': timeFrom,
        'timeTo': timeTo,
        'location': location,
        'locationAddress': locationAddress,
        'number': number,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // 4. delete
  Future<bool> deleteBoard(String boardId) async {
    try {
      //1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      //2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('boards');

      // 3. 문서 참조 만들기
      final docRef = collectionRef.doc(boardId);

      // 4. 삭제
      await docRef.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

    // 서버에서 받은 데이터
//     String serverResponse = """
// [
//   {
//     "type": "soccer",
//     "title": "친목 축구 모임",
//     "content": "신규 회원 환영! 편하게 오세요.",
//     "date": "2025-05-03",
//     "timeFrom": 10,
//     "timeTo": 12,
//     "location": "서울 월드컵 공원 축구장",
//     "locationAddress": "서울특별시 마포구 성산동 682-3",
//     "number": 14
//   },
//   {
//     "type": "futsal",
//     "title": "주말 풋살 데이",
//     "content": "풋살화만 챙겨오세요!",
//     "date": "2025-05-10",
//     "timeFrom": 18,
//     "timeTo": 20,
//     "location": "강남실내풋살센터",
//     "locationAddress": "서울특별시 강남구 역삼동 712-14",
//     "number": 8
//   },
//   {
//     "type": "basketball",
//     "title": "농구 스크리밍",
//     "content": "3대3 농구 즐기실 분 모집합니다.",
//     "date": "2025-05-15",
//     "timeFrom": 15,
//     "timeTo": 17,
//     "location": "잠실실내체육관",
//     "locationAddress": "서울특별시 송파구 올림픽로 25",
//     "number": 6
//   },
//   {
//     "type": "running",
//     "title": "한강 러닝 모임",
//     "content": "한강변 10km 러닝 같이 하실 분!",
//     "date": "2025-05-20",
//     "timeFrom": 7,
//     "timeTo": 9,
//     "location": "여의도 한강공원",
//     "locationAddress": "서울특별시 영등포구 여의동로 330",
//     "number": 20
//   },
//   {
//     "type": "soccer",
//     "title": "저녁 축구 레슨",
//     "content": "초보자도 환영하는 축구 레슨.",
//     "date": "2025-05-25",
//     "timeFrom": 19,
//     "timeTo": 21,
//     "location": "상암월드컵경기장",
//     "locationAddress": "서울특별시 마포구 성산동 255-10",
//     "number": 12
//   },
//   {
//     "type": "futsal",
//     "title": "친선 풋살 대회",
//     "content": "소규모 풋살 대회 참가자 모집.",
//     "date": "2025-06-01",
//     "timeFrom": 14,
//     "timeTo": 17,
//     "location": "수원 실내 풋살장",
//     "locationAddress": "경기도 수원시 팔달구 고등동 987-5",
//     "number": 10
//   },
//   {
//     "type": "basketball",
//     "title": "아침 농구클럽",
//     "content": "1시간 슛 훈련 및 경기 진행.",
//     "date": "2025-06-05",
//     "timeFrom": 8,
//     "timeTo": 9,
//     "location": "건대입구 농구장",
//     "locationAddress": "서울특별시 광진구 화양동 8-11",
//     "number": 10
//   },
//   {
//     "type": "running",
//     "title": "산책 겸 러닝",
//     "content": "초급 러닝 및 산책 코스.",
//     "date": "2025-06-10",
//     "timeFrom": 10,
//     "timeTo": 12,
//     "location": "북한산 둘레길",
//     "locationAddress": "서울특별시 강북구 우이동 산1-1",
//     "number": 15
//   },
//   {
//     "type": "soccer",
//     "title": "풋사커 혼합 경기",
//     "content": "축구와 풋살의 중간 형태 경기.",
//     "date": "2025-06-15",
//     "timeFrom": 16,
//     "timeTo": 18,
//     "location": "인천 축구센터",
//     "locationAddress": "인천광역시 서구 석남동 1234",
//     "number": 16
//   },
//   {
//     "type": "basketball",
//     "title": "농구 3점슛 챌린지",
//     "content": "3점슛 고수 모여랏!",
//     "date": "2025-06-20",
//     "timeFrom": 17,
//     "timeTo": 19,
//     "location": "천안 축구센터",
//     "locationAddress": "충청남도 천안시 동남구 유량동 456-2",
//     "number": 8
//   }
// ]

// """;

//     // 서버에서 받은 JSON 형식의 문자열 데이터를 Map으로 변환
//     final List<dynamic> jsonList = jsonDecode(serverResponse);

//     final List<Board> boards =
//         jsonList
//             .map((json) => Board.fromJson(json as Map<String, dynamic>))
//             .toList();

//     return boards;
//   }

