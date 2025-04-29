# Readme

# 🏃운동하실? Project

---

<div align="center" style="display: flex; flex-wrap: nowrap; overflow-x: auto; padding: 10px;">
  <img src="https://github.com/user-attachments/assets/589c1812-1538-461c-a2b2-8a41532d75ce" width="120" style="margin: 10px; flex-shrink: 0;"> <!--스플래쉬-->
  <img src="https://github.com/user-attachments/assets/e6ae87ce-e111-41e6-af48-20c79cf835ce" width="120" style="margin: 10px; flex-shrink: 0;"> <!--로그인-->
  <img src="https://github.com/user-attachments/assets/834b9cb3-31d4-4606-a81b-fd127fa10c3d" width="120" style="margin: 10px; flex-shrink: 0;"> <!--회원가입-->
  <img src="https://github.com/user-attachments/assets/f85ca9fc-64b8-44a3-b38f-364c6260e0d3" width="120" style="margin: 10px; flex-shrink: 0;"> <!--메인-->
  <img src="https://github.com/user-attachments/assets/974cf254-427c-49ea-8db1-553ca9447361" width="120" style="margin: 10px; flex-shrink: 0;"> <!--보드게시판-->
  <img src="https://github.com/user-attachments/assets/d3817a16-5245-49e2-bad9-9588e671d2d2" width="120" style="margin: 10px; flex-shrink: 0;"> <!--보드게시판 디테일-->
  <img src="https://github.com/user-attachments/assets/be80dae1-b62c-4141-87d4-d3322b13cc00" width="120" style="margin: 10px; flex-shrink: 0;"> <!--게시판 작성페이지-->
  <img src="https://github.com/user-attachments/assets/3f738827-1cf0-4f6d-9356-479cdd02236e" width="120" style="margin: 10px; flex-shrink: 0;"> <!--지도-->
  <img src="https://github.com/user-attachments/assets/13b94bf1-1027-4e26-a6ff-055231aa69c1" width="120" style="margin: 10px; flex-shrink: 0;"> <!--채팅 목록-->
  <img src="https://github.com/user-attachments/assets/8d9de90f-14e6-42e7-88f5-0e9e611907b6" width="120" style="margin: 10px; flex-shrink: 0;"> <!--프로필 이미지-->
  <img src="https://github.com/user-attachments/assets/79bb9b04-1f2a-47a3-ad06-b8d8b0393bd2" width="120" style="margin: 10px; flex-shrink: 0;"> <!--프로필 수정-->
</div>


## 💰 ’목표 자산 5조’ 팀소개

- **팀명**: 목표 자산 5조
- **팀원**: 손진성(팀장), 전진주, 양준석, 고한동, 김민지
- **슬로건**: "열심히 해서 5조 벌자!"

---
## 👨‍🏫 프로젝트 소개

- 운동 모임을 쉽게 찾고, 참여할 수 있도록 도와주는 위치 기반 모임 서비스입니다.
- 근처에서 열리는 러닝, 풋살, 농구, 축구 모임을 빠르게 확인하고 바로 신청할 수 있습니다.

---

## ⚽︎ 프로젝트 계기

- 코로나 이후 오프라인 운동 모임 수요 증가
- 지역 기반 소모임 앱은 많지만 운동 특화된 서비스는 부족함
- 친구 없이도 가볍게 운동할 수 있는 플랫폼 만들고 싶음

---

## ⏲️ 개발기간

- 2025.4.22(수) ~ 2025.4.30(수)

---

## 💻  주요기능

### 기능 1 로그인 및 회원가입 기능

- Firebase Authentication을 이용하여 사용자는 간편하게 로그인 및 회원가입이 가능합니다.

### 기능2 운동 모임 모집 게시판

- 사용자가 직접 운동 모임을 생성하고, 상세 정보를 게시할 수 있습니다.

### 기능3 채팅 기능

- 참여한 모임의 참가자들과 1:1 또는 그룹 채팅을 통해 소통할 수 있습니다.

### 기능4 모임 검색 기능

- 지역명, 장소명을 입력하여 원하는 운동 모임을 빠르게 검색할 수 있습니다.
- 지도 마커 클릭 시 모임 정보(제목, 시간, 내용)를 확인할 수 있으며, 참여 버튼을 통해 바로 채팅방에 입장할 수 있습니다.

### 기능5 프로필 등록 및 수정기능

- 로그인한 사용자는 프로필 사진과 닉네임을 등록 및 수정할 수 있습니다.

---

## 📚️ 기술스택

### Language

- Dart

### Version Control

- git / github

### IDE

- VSCode

### Framework

- Flutter
- Firebase (Authentication, Firestore)

### DBMS

- Firebase Firestore

---

## 와이어프레임

---

# 📚 API 명세서

## 🗺️ 지도 & 위치 관련 API

### 1. Flutter Naver Map
- **사용 목적**: 지도 UI 표시, 마커 추가 및 클릭 이벤트, 카메라 이동
- **사용 패키지**: `flutter_naver_map`
- **주요 기능**:
  - 지도 띄우기
  - 마커 추가 및 클릭 시 모임 정보 표시
  - 내 현재 위치로 지도 이동

---

### 2. Geolocator
- **사용 목적**: 디바이스의 현재 GPS 위치 가져오기
- **사용 패키지**: `geolocator`
- **주요 기능**:
  - 현재 위치 정보 가져오기
  - 위치 권한 요청 및 체크

---

### 3. Kakao Local API (장소 검색 API)
- **사용 목적**: 키워드(장소명, 지역명) 검색 후 좌표(위도/경도) 변환
- **API 엔드포인트**: `https://dapi.kakao.com/v2/local/search/keyword.json`
- **요청 방식**: `GET`
- **요청 헤더**: 
  - `Authorization: KakaoAK {REST_API_KEY}`
- **요청 파라미터**:
  - `query`: 검색할 장소명
- **주요 기능**:
  - 키워드 기반 장소 검색
  - 검색된 장소의 위도(lat), 경도(lng) 반환


### 🔐 4. Firebase Authentication

- **사용 목적**: 사용자 로그인 및 회원가입 기능 구현
- **사용 패키지**: `firebase_auth`
- **주요 기능**:
  - 이메일/비밀번호 기반 회원가입 및 로그인
  - Firebase Auth를 통한 인증 상태 유지
  - 인증된 사용자(User)의 UID 관리

## 🗄️ 5. Firebase Firestore

- **사용 목적**: 운동 모임 데이터, 채팅방, 사용자 프로필 데이터 저장 및 조회
- **사용 패키지**: `cloud_firestore`

---

## 📂 프로젝트 파일 구조
lib/
├── core/                    # 앱 공통 유틸 (입력처리, 유효성 검사 등)
│   ├── email_to_phone.dart
│   ├── on_submitted_func.dart
│   └── validator_util.dart
│
├── data/                    # 데이터 관리 (모델, 프로바이더, 저장소, 뷰모델)
│   ├── models/              # 데이터 모델 정의
│   │   ├── board.dart
│   │   ├── chat.dart
│   │   ├── chat_message_model.dart
│   │   ├── chat_user_model.dart
│   │   ├── post.dart
│   │   └── profile.dart
│   ├── providers/           # 상태관리 (riverpod providers)
│   │   ├── auth_provider.dart
│   │   ├── board_provider.dart
│   │   ├── chat_provider.dart
│   │   ├── chat_user_provider.dart
│   │   ├── map_provider.dart
│   │   └── user_provider.dart
│   ├── repositories/        # Firebase 연결, 데이터 통신 코드
│   │   ├── auth_repository.dart
│   │   ├── board_repository.dart
│   │   ├── chat_repository.dart
│   │   ├── chat_user_repository.dart
│   │   ├── map_repository.dart
│   │   └── profile_repository.dart
│   └── view_models/         # 로직 처리 (화면 뷰모델)
│       ├── auth_view_model.dart
│       ├── board_view_model.dart
│       ├── chat_view_model.dart
│       ├── home_content_view_model.dart
│       ├── login_user_view_model.dart
│       ├── map_view_model.dart
│       └── user_view_model.dart
│
├── pages/                   # 실제 화면(UI) 코드
│   ├── board/               # 게시판 관련 화면
│   │   ├── address_search_page.dart
│   │   ├── board_detail_page.dart
│   │   └── create_post_page.dart
│   │   └── widgets/
│   │       ├── board_item.dart
│   │       └── filter_button.dart
│   ├── chat/                # 채팅 관련 화면
│   │   ├── chat_page.dart
│   │   ├── chat_room_page.dart
│   │   └── chat_user_list.dart
│   │   └── widgets/
│   │       ├── chat_room_bottomsheet.dart
│   │       ├── chat_room_list_view.dart
│   │       ├── chat_room_receive.dart
│   │       └── chat_room_send.dart
│   ├── home/                # 홈 화면
│   │   └── home_page.dart
│   │   └── widgets/
│   │       ├── build_activity_button.dart
│   │       ├── custom_bottom_nav_bar.dart
│   │       └── home_content_page.dart
│   ├── login/               # 로그인 화면
│   │   └── login_page.dart
│   ├── map/                 # 지도 화면
│   │   ├── map_page.dart
│   │   └── widgets/
│   │       ├── event_card_widget.dart
│   │       └── search_bar_widget.dart
│   ├── profile/             # 프로필 수정 화면
│   │   ├── edit_profile_page.dart
│   │   └── profile_page.dart
│   ├── register/            # 회원가입 화면
│   │   └── register_page.dart
│   ├── splash/              # 앱 시작화면
│   │   └── home_after_splash.dart
│   └── widgets/             # 공통 위젯들
│       ├── phone_text_form_field.dart
│       ├── pw_text_form_field.dart
│       ├── show_confirm_pop_up.dart
│       ├── show_custom_snack_bar.dart
│       └── user_profile_image.dart
│
├── themes/                  # 테마(앱 전체 스타일)
│   └── light_theme.dart
│
├── utils/                   # 유틸리티 (카카오맵, 파이어베이스옵션 등)
│   └── kakao_location_helper.dart
├── firebase_options.dart
│
└── main.dart                 # 앱 시작점