### 플러터 토이 프로젝트 MVT (MovieTime) 입니다. 🔊🔊

- ## 2023-07-19
  - [x] 메인 페이지 및 TMDB  API 데이터 조회 완료
  - [x] 메인 페이지 SearchBar 구현 완료
  - [X] 바텀 내비게이션 구현 완료
  - [X] 스플래시 페이지 구현 완료

- ## 2023-07-20
  - [X] TMDB API 영화 상세 데이터 조회 완료
  - [X] TMDB API 배우 데이터 조회 완료
 
- ## 2023-07-21
  - [X] 회원가입 페이지 구현 완료
 
- ## 2023-07-23
  - [X] googleMap API 연동
  - [X] 사용자가 배우 이름 입력 후 클릭하면 다이얼로그 창 구현 완료 (다이얼로그 내용은 리스트뷰에서 클릭한 배우 이름을 조회하고, ElevatedButton 클릭 시 Firebase에 등록된다.)
  - [X] 사용자가 원하는 배우 이름 입력할 때마다 입력한 텍스트들이 안보이는 현상 수정
 
- ## 2023-07-24
  - [X] Firebase 연동 완료
  - [X] 배우 클릭 후 다이얼로그 확인 후 버튼 클릭 시 Firebase에 등록되고, 프로필 탭에서 확인 가능.
  - [X] 프로필 페이지 구현 완료
  - [X] 좋아요 바텀바 추가
 
- ## 2023-07-25
  - [X] 회원가입 & 파이어베이스 연동 완료
  - [X] 이메일과 비밀번호 입력 시 파이어베이스 Authentication 등록
  - [X] 스플래시 페이지에서 회원가입이 되어 있다면 메인 페이지, 안되어 있다면 회원가입 페이지로 이동
  - [X] 프로필 페이지에서 사용자가 입력한 이메일 조회
 
- ## 2023-07-26
  - [X] 프로필 페이지에서 사용자가 닉네임 입력 시 파이어베이스에 등록
  - [X] 앱을 껐다 키면 입력한 닉네임이 사라지는 이슈 해결 (SharedPreferences 사용)
  - [X] 로그인 페이지 구현 완료
  - [X] getX 연동, 라우트 연결  

- ## 2023-07-27
  - [X] 스플래시 디자인 애니메이션 사진 적용 (Lottie 사용)

- ## 2023-07-29
  - [X] 프로필 페이지 핸드폰 갤러리 구현
  - [X] 갤러리에서 선택한 이미지를 가져오면 프로필 사진 등록

- ## 2023-07-30
  - [X] 로그아웃 기능 구현
  - [X] 홈, 좋아요, 프로필 스크린 FutureBuilder 적용 (영화 불러올 때, 닉네임 조회할 때 사용) 

- ## 2023-07-31
  - [X] 홈 스크린에서 배우 입력할 때마다 FutureBuilder 적용되는 현상 수정
  - [X] 프로필 스크린에 갤러리에서 사진 선택하면 파어어베이스에 등록
  - [X] 프로필 스크린에서 파이어베이스에 등록한 이미지 불러오기 (사용자 고유 UID)

- ## 2023-08-04
  - [X] 회원가입, 로그인 페이지 유효성 검사 기능 구현
         

<br><br>

## 회원가입 페이지
<img src="https://github.com/hyunho4532/flutter-MVT-Project/assets/118269278/76add49e-f185-4b62-bad8-1e3ee8776eb6" width=350 height=700>


<br><br>

## 영화 메인 페이지
<img src="https://github.com/hyunho4532/flutter-MVT-Project/assets/118269278/06ca2e3d-764c-4827-b525-baea8dbef542" width=350 height=700>

<img src="https://github.com/hyunho4532/flutter-MVT-Project/assets/118269278/e4832037-36b8-4782-ac91-9727c8dd5c42" width=350 height=700>

<hr>

### API 관련 안내
<a href="https://www.themoviedb.org/">TMDB</a><br>
<a href="https://developers.google.com/maps">google map</a>
