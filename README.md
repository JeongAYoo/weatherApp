# weatherApp
![image](https://user-images.githubusercontent.com/26922015/230777499-66ee8c0e-45be-4039-8944-79c5cb72cfbe.png)

## 🏴‍☠️ Issue & Solution

### 1. 검색한 지역의 시간별, 일별 날씨가 처음 지역의 날씨와 똑같이 나오는 문제

<aside>
✅ 실시간 날씨만 표시하는 현재 날씨와 달리<br>
시간별, 일별 데이터는 배열로  받아오는데 처음에만 클래스 내부에서 빈 배열로 초기화하고,<br>
데이터를 받아오는 fetch함수에서 계속 날씨 데이터를 기존 배열에 추가하기만 한것.<br>
초기에 한 지역만 표시할때는 이 문제를 깨닫지 못했음.<br>
<br>
→ 함수 내부 맨 앞에 배열을 빈 배열로 초기화 코드를 추가하니 해결.

</aside>

---

### 2. 현재, 최고, 최저 온도를 반올림하여 문자열로 설정하는 코드의 중복

<aside>
✅ WeatherKit에서 주는 모든 온도는 `Measurement<UnitTemperature>` 타입인데<br>
처음에는 `.value` 로 접근해 Double 타입의 값을 데이터 모델에 저장하고 다시 문자열로 타입 변환 후 섭씨 기호를 추가해 Label에 표시하였다.<br>
<br>
같은 코드가 커스텀 UIView와 Cell에서 중복되고, 온도 기호를 매번 문자열로 추가하는 것은 비효율적으로 보여 `MeasurementFormatter` 를 이용
<br>
→ 온도를 반올림, 소수점 제거, 지역에 따라 섭씨 또는 화씨로 표시되게끔 포맷을 설정하고
내장 함수를 사용해 포맷에 따른 문자열을 Label의 text로 설정하였다.
<br>
</aside>

```swift
self.currentTempLabel.text = formatter.string(from: weather.temperature)
```

```swift
class TemperatureFormatter {
    let formatter = MeasurementFormatter()
    
    init() {
        formatter.locale = Locale.init(identifier: "ko_KR")
        formatter.numberFormatter.roundingMode = .up
        formatter.numberFormatter.maximumFractionDigits = 0
    }
}
```
---
### 3. CLLocation → String 변환 후 Label Text에 표시되지 않음

<aside>
✅ 위도와 경도를 가진 CLLocation 타입의 위치 데이터를 `CLGeocoder`의 `reverseGeocodeLocation` 함수를 통해 “서울특별시” 등의 문자열로 바꾸어 상단의 UIView의 Label text로 표시하였는데
<br>
이후 이 문자열을 위도, 경도와 함께 데이터베이스에 저장하기 위해서<br>
내부에서 `reverseGeocodeLocation`함수를 호출하는 함수를 따로 정의하였는데 Label의 text가 도시이름을 표시하지 않았다.<br>
<br>
 `reverseGeocodeLocation`함수는 비동기적으로 동작하는데 이 함수를 다른 함수 내부로 옮겨 호출하는 과정에서 그대로 문자열을 return을 해버린 것.
<br>
→ 감싸고 있는 함수의 인자에 escaping 클로저를 전달하여 해결
<br>
</aside>

<br><br>

## 📚 Library

### WeatherKit

- [애플 공식문서](https://developer.apple.com/weatherkit/)를 참고하여 WeatherKit에서 현재, 시간별, 일별 날씨 데이터를 받았습니다.

### Realm

- 추가한 지역을 디바이스에 저장하기 위해 사용

```swift
UserCity: 검색 후 추가한 지역을 저장하는 Table

- human readable ‘도시명’ (String 타입)
- 위도, 경도 (CLLocation Degress a.k.a Double 타입)
```

### SnapKit

- AutoLayout을 설정에 있어 편의성을 위해 사용

### SideMenu

- 저장한 지역리스트를 보여주기 위함

<br><br>

## 🎨 UI

3명의 스터디원과 함께 Figma로 UI를 구상하고 이후 개인적으로 개발하였습니다.

### Figma

[https://www.figma.com/file/brg4aoea1zyJktbB05fc8S/Untitled?node-id=0%3A1&t=fKDMNEAPFXEYueaN-1](https://www.figma.com/file/brg4aoea1zyJktbB05fc8S/Untitled?node-id=0%3A1&t=fKDMNEAPFXEYueaN-1)

<br><br>

## ⚒️ 추가 사항

추가적으로 구현하거나, 개선해야할 것들

- identifier 등 문자열 리터럴을 따로 변수에 담아서 관리
- 네트워크 연결이 안되거나, 로딩이 느릴 때 → 유저에게 알리기
- 마지막으로 선택한 지역을 다음 앱 실행시 메인 화면에 보여주기
- 저장한 지역 리스트 순서 변경
