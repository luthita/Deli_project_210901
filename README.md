# Deli_project(배달 앱 PC 버전)
Date : 2021/09/01 ~ 2021/10/01( 1 달간)

## 📢 프로젝트 설명
* 1인 프로젝트
* Spring Boot 를 이용한 웹 서비스를 개발 경험을 쌓기 위해서 [배달의민족]을 복제한 프로젝트 개발
* 기본적인 로그인/ 가게 및 메뉴 등록 / 주문 및 찜하기 / 리뷰 달기 기능 수행

## ✏️ 사용 기술
<strong>Language</strong> : JAVA . Javascript . html . css . SQL . <br>
<strong>Framework</strong> : SpringBoot . Bootstrap . JQuery <br>
<strong>Tool</strong> : MySQL . Github . AWS EC2 <br>

## 🛠 설계 🛠
* 프로젝트 기획서 
  * [일정/기획 Link!](https://docs.google.com/spreadsheets/d/1QjXubuThmLomBp4M6U_rc2xGJV8dZ16J1i2C2SKwbBw/edit#gid=2054002035, "프로젝트 기획서")

* 프로젝트 DB 설계 
  * [DB 설계 Link!](https://docs.google.com/spreadsheets/d/1QjXubuThmLomBp4M6U_rc2xGJV8dZ16J1i2C2SKwbBw/edit#gid=1368487158, "DB 설계")

* 프로젝트 URL 설계
  * [URL 설계 Link!](https://docs.google.com/spreadsheets/d/1QjXubuThmLomBp4M6U_rc2xGJV8dZ16J1i2C2SKwbBw/edit#gid=606285945, "URL 설계")
* 프로젝트 프로토타이핑
  * [화면 정의 Link!](https://ovenapp.io/view/j7fKK6JcomnQl3GcgcwKNDQ5509fwhbl/,"프로토타이핑")
<hr>

## ⛏ 주요기능 ⛏

* 회원가입(user)
  - package : [com.luthita.user.*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/java/com/luthita/user)
  - view : [webapp/WEB-INF/jsp/user/*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/webapp/WEB-INF/jsp/user)
* 로그인(user)
  - package : [com.luthita.user.*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/java/com/luthita/user)
  - view :[webapp/WEB-INF/jsp/user/*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/webapp/WEB-INF/jsp/user)
* 장바구니
  - package : [com.luthita.basket.*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/java/com/luthita/basket)
  - view : [webapp/WEB-INF/jsp/main/basket.jsp](https://github.com/luthita/Deli_project_210901/blob/develop/src/main/webapp/WEB-INF/jsp/main/basket.jsp)
* 주문하기
  - package : [com.luthita.order.*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/java/com/luthita/order)
  - view : [webapp/WEB-INF/jsp/main/order.jsp](https://github.com/luthita/Deli_project_210901/blob/develop/src/main/webapp/WEB-INF/jsp/main/order.jsp)
* 리뷰
  - package : [com.luthita.review*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/java/com/luthita/review)
  - view : [webapp/WEB-INF/jsp/main/review.jsp](https://github.com/luthita/Deli_project_210901/blob/develop/src/main/webapp/WEB-INF/jsp/main/review.jsp)
* 찜
  - package : [com.luthita.store.bo.*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/java/com/luthita/store/bo)
  - view(찜 목록) : [webapp/WEB-INF/jsp/main/like_list.jsp](https://github.com/luthita/Deli_project_210901/blob/develop/src/main/webapp/WEB-INF/jsp/main/like_list.jsp)
* 가게
  - package : [com.luthita.store.*](https://github.com/luthita/Deli_project_210901/tree/develop/src/main/java/com/luthita/store)
  - view : [webapp/WEB-INF/jsp/main/store.jsp](https://github.com/luthita/Deli_project_210901/blob/develop/src/main/webapp/WEB-INF/jsp/main/store.jsp)

<hr>

## 📷 미리보기 📷

### * 회원가입 & 로그인 (User)
![signUp&In](https://user-images.githubusercontent.com/86404947/136156417-12ed9b84-31c2-4ed0-a5bb-3a37039e815c.gif)

### * 장바구니 담기
![basket](https://user-images.githubusercontent.com/86404947/136158282-db0d20cc-e5d0-4e3d-b787-d3994b9eb151.gif)


### * 주문하기
![order](https://user-images.githubusercontent.com/86404947/136158850-23176ea7-6088-42e9-8211-ed6f9ea48f4b.gif)


### * 주문 상세 & 리뷰
![orderDetail&review](https://user-images.githubusercontent.com/86404947/136158531-5a0e6b39-37ef-4be0-9b11-c39ef2ca3a51.gif)

### * 찜
![like](https://user-images.githubusercontent.com/86404947/136158903-4de41d4a-b475-48f7-addb-40d949c8aa6e.gif)

### * 가게등록
![storeSignUp](https://user-images.githubusercontent.com/86404947/136160685-24747b00-6df6-4a10-bba7-5c9c447088ef.gif)

### * 가게 수정 & 메뉴 등록
![menuSignUp](https://user-images.githubusercontent.com/86404947/136160736-90544a76-0f5c-43fc-ad58-802b91d2e09d.gif)

<hr>

## 🎁 향후 추가할 기능 및 계획 🎁
 * Admin
   - 메뉴 품절 기능 추가
   - 가게 등록한 주소를 지도로 띄우기
   - 사장님댓글 기능 추가
   - 쿠폰 기능 추가
 * User
   - 리뷰 수정 기능 추가
   - 주문 내역 삭제 기능
   - 회원 정보 변경 기능
   - 비밀번호 

