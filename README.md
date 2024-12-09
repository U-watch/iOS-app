# 클론 후 의존성 설치

"U-watch.xcworkspace 파일이 있는 곳에서"


### pod install



------------- 
1. git clone 하고
2. git fetch --all
3. git checkout feature/google-login
4. cd U-watch
5. pod install
6. 하고 걍 xcode 실행하면됨 실제폰으로 할거면 맥북에 아이폰 케이블로 연결해줘야함, 에뮬레이터 돌릴거면 에뮬레이터 고르고 실행


 ⚠️ pod install을 설치한 이후부터는 반드시 파란색 .xcodeproj 파일이 아니라, 새로 생긴 흰색 .xcworkspace 파일로 실행해줘야만 정상적으로 작동하게 된다!
