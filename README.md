# memo_bloc_firebase

## 취업용 포트폴리오

1. 이름 : MemoBuddy
2. 설명 : 최소한의 기능만 있는 심플한 메모 앱
3. defendencies :
    - cupertino_icons: ^1.0.2
    - provider: ^4.3.3
    - firebase_core: ^1.0.0
    - firebase_storage: ^8.0.0
    - cloud_firestore: ^1.0.0
    - image_picker: ^0.7.2
4. 레이아웃은 Udemy의 엔젤라 유의 강의에서 예전에 튜토리얼로 썼던 todolist 앱을 거의 똑같이 배꼈다.
5. 반성 : provider로 state management 하려고 했는데 firestore의 데이터 스냅샷이 스트림 타입으로 데이터를 제공해줘서 streambuilder로 뿌려주니 딱히 별도의 state 관리를 해줄 필요가 없었다.  flutter의 Firebase plugin이 자체적으로 static singleton 패턴으로 instance를 제공하기 때문에 firebaseManager같은 매니저 클래스 하나 만들어 놓고 관련 코드 모아서 사용하면 충분히 관리하기 유용할듯 하다.

* /app-debug.apk 파일로 설치 (못찾는 분들을 위해 루트로 빼놓음)
