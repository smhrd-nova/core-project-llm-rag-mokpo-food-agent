# 🍜 오늘 뭐 목포?

### LLM/RAG 기반 목포 로컬 미식 추천 AI Agent

> **검색해서 고르는 목포가 아니라,
> 오늘의 조건에 맞는 목포를 AI가 설계합니다.**

**TEAM NOVA**의 핵심프로젝트입니다.

사용자의 **시간 · 예산 · 동행 · 이동수단 · 음식 취향**을 자연어 또는 조건 입력으로 받아 분석하고, 목포 로컬 데이터를 기반으로 개인에게 적합한 **먹거리와 미식 코스**를 추천하는 AI Agent 서비스를 개발합니다.

---

## 📌 Project Overview

목포에는 다양한 음식점, 카페, 시장 등의 정보가 존재하지만 사용자가 실제 여행 계획을 세울 때는 검색, 지도, 리뷰, 가격, 영업시간, 거리 등의 정보를 직접 비교해야 합니다.

본 프로젝트는 이러한 **정보 부족보다 '선택과 조합의 어려움'**에 주목합니다.

사용자의 여행 상황을 Context로 추출하고, 목포 로컬 데이터와 RAG를 활용하여 조건에 맞는 장소를 검색·분석한 뒤, 실행 가능한 미식 코스를 생성하는 것을 목표로 합니다.

### 핵심 흐름

```text
사용자 입력
   ↓
Context 추출
   ↓
여행 조건 분석
   ↓
목포 Local DB 검색
   ↓
RAG 기반 정보 검색
   ↓
조건 필터링
   ↓
추천 Ranking
   ↓
미식 코스 생성
   ↓
예상 비용 / 추천 이유 제공
   ↓
지도 연결
   ↓
사용자 피드백
```

---

## 🎯 Project Goal

### "오늘 먹을 목포를 검색하는 것이 아니라, AI가 설계한다."

사용자의 복합적인 여행 조건을 분석하여 단순 장소 검색을 넘어 **개인 맞춤형 목포 미식 경험**을 제공하는 것을 목표로 합니다.

### 주요 목표

* 자연어 기반 여행 조건 분석
* 목포 로컬 음식·카페·시장 데이터 구축
* Local DB + RAG 기반 근거 중심 추천
* 사용자 조건에 따른 장소 필터링 및 Ranking
* 개인 맞춤형 미식 코스 생성
* 예상 비용 및 이동 동선 제공
* 추천 이유와 데이터 근거 제공
* 사용자 피드백을 통한 개인화 확장

---

## ✨ Core Features

| 기능            | 설명                             | 요구사항  |
| ------------- | ------------------------------ | ----- |
| 여행 조건 입력      | 시간, 예산, 동행, 이동수단, 관심사 등을 입력    | FR-01 |
| 조건 검증·저장      | 입력된 조건의 유효성 검증 및 저장            | FR-02 |
| 장소 탐색         | 키워드 및 카테고리 기반 목포 장소 검색         | FR-03 |
| Local Data 결합 | 공공데이터 + 로컬 데이터 + 현지인 선택 데이터 활용 | FR-04 |
| 장소 상세 정보      | 장소 설명 및 추천 상황 제공               | FR-05 |
| 조건 분석         | 사용자 조건과 로컬 데이터를 비교·분석          | FR-06 |
| 맞춤 추천         | 조건에 맞는 장소 및 코스 생성              | FR-07 |
| 추천 결과 제공      | 맞춤형 추천 결과 화면 제공                | FR-08 |
| 결과 확인         | 장소 및 여행 코스 상세 확인               | FR-09 |
| 저장·공유         | 추천 장소 및 코스 저장·공유               | FR-10 |
| 재추천           | 조건 변경 후 다시 추천 요청               | FR-11 |

---

## 🧠 AI Recommendation

본 서비스의 핵심은 단순 LLM 응답이 아닌 **목포 특화 Local DB와 RAG를 결합한 추천 구조**입니다.

### 추천 데이터

* 사용자 시간
* 예산
* 동행 유형
* 이동수단
* 음식 취향
* 음식점 / 카페 / 시장 정보
* 메뉴 및 가격
* 주소 및 위치
* 영업시간
* 편의정보
* 현지인 방문 경험
* 방문 빈도
* 재방문 의향
* 추천 이유
* 추천 상황

### Recommendation Pipeline

```text
Natural Language Input
        ↓
Context Extraction
        ↓
User Preference Structuring
        ↓
Local DB Retrieval
        ↓
RAG Search
        ↓
Constraint Filtering
        ↓
Recommendation Ranking
        ↓
Course Generation
        ↓
Recommendation Explanation
```

---

## 🗺️ Service Flow

서비스의 전체 사용자 경험은 다음과 같이 구성합니다.

```text
오늘 뭐 목포?
      ↓
AI에게 물어보기
      ↓
내 조건 분석
      ↓
먹거리 추천
      ↓
오늘의 미식 코스
      ↓
지도에서 보기
```

주요 화면 구성은 다음과 같습니다.

* 홈
* 여행 만들기
* AI에게 물어보기
* 내 조건 분석
* 목포 탐색
* 먹거리 추천
* 오늘의 미식 코스
* 여행 중
* 여행자 기록
* 나의 목포
* 라운지
* 추천 데이터 흐름

---

## 🖥️ Prototype

현재 **HTML 기반 통합 프로토타입**을 구현하여 서비스의 전체 사용자 흐름과 UI/UX를 검증하고 있습니다.

### 현재 프로토타입에서 확인할 수 있는 주요 기능

* 반응형 웹 UI
* 여행 조건 입력 화면
* AI 대화형 입력 화면
* 음식 취향 선택
* 목포 장소 탐색
* 추천 결과 화면
* 여행 코스 화면
* 여행자 기록
* 나의 목포
* 여행 공유 및 가져오기
* 서비스 소개 및 추천 데이터 흐름

> 현재 프로토타입은 **UI/UX 및 서비스 흐름 검증 단계**이며, 실제 AI·관광·지도 API 연결은 추후 진행 예정입니다.

## 🌐 Web Integration

기존 HTML 프로토타입을 실제 웹서비스로 확장하기 위한
Node.js + Express 기반 Backend 구조를 구축하였다.

현재는 Local 환경에서 웹서버를 실행하고,
Frontend와 Backend 간 API 통신 구조를 검증하였다.

### 현재 구조

Frontend
↓
Node.js + Express Backend
↓
Demo Data

### 구현 완료

- Frontend ↔ Backend API 구조
- 장소 조회 API
- 추천 API
- AI Chat API Interface
- RAG API Interface
- Local Web Server 실행

> 현재 Chat / RAG API는 Demo Fallback 방식으로 동작하며,
> 실제 LLM 및 Vector DB 연동을 위한 API Interface를 먼저 구성하였다.

현재 AI/RAG는 Demo 단계이며,
향후 실제 LLM, Tavily Search, Vector DB 및 관광 데이터를 연동할 예정이다.
---

## 🏗️ Tech Stack

### AI / Data

* Python
* Pandas
* NLP
* Text Mining
* LLM
* RAG
* LangChain
* AI Agent

### Backend

* FastAPI

### Frontend

* HTML
* CSS
* JavaScript

### Data

* Local Database
* Public Data
* Crawling
* API
* Data Cleaning / Validation

### External Service

* 지도 연동 API

---

## 📊 Data Strategy

목포 지역의 먹거리 정보를 단순 수집하는 것이 아니라 **추천에 활용할 수 있는 구조화된 Local Data**로 구축하는 것을 목표로 합니다.

### Data Sources

* 공공데이터
* 목포시 및 관광 공식자료
* 지도·업체 공식정보
* 직접 조사 데이터
* 현지인 설문 데이터

### Data Collection

```text
공공데이터 / 공식자료 / 조사
           ↓
      데이터 수집
           ↓
      Crawling / API
           ↓
        데이터 정제
           ↓
      수작업 검증
           ↓
       Local Database
           ↓
       RAG / AI Agent
```

### 주요 데이터

| Category | Data          |
| -------- | ------------- |
| 장소       | 음식점, 카페, 시장   |
| 메뉴       | 메뉴명, 가격       |
| 위치       | 주소, 좌표        |
| 운영       | 영업시간          |
| 편의정보     | 주차, 기타 편의정보   |
| 로컬 데이터   | 방문 빈도, 재방문 의향 |
| 추천 정보    | 추천 이유, 추천 상황  |

---

## 🔍 Differentiation

기존 지도·검색 서비스와 달리 본 프로젝트는 **"장소를 찾는 것"이 아니라 "오늘의 조건에 맞는 식사 경험을 설계하는 것"**을 목표로 합니다.

### 기존 서비스

```text
검색
 ↓
장소 목록
 ↓
사용자가 직접 비교
 ↓
사용자가 직접 코스 구성
```

### 오늘 뭐 목포?

```text
"오늘 부모님과 목포에서 5만원 정도로
차를 가지고 다니면서 맛있는 걸 먹고 싶어."

          ↓

AI Context 분석

          ↓

목포 Local DB + RAG

          ↓

조건 필터링 + Ranking

          ↓

추천 이유 생성

          ↓

최적 미식 코스 생성
```

---

## 📋 Requirements

### Functional Requirements

* FR-01 여행 조건 입력
* FR-02 조건 데이터 검증·저장
* FR-03 키워드·카테고리 기반 장소 조회
* FR-04 공공·로컬 데이터 결합 조회
* FR-05 장소 상세 정보 제공
* FR-06 조건-설문 데이터 대조·분석
* FR-07 개인 맞춤 장소·코스 생성
* FR-08 맞춤 추천 결과 화면 구성
* FR-09 추천 결과 확인
* FR-10 추천 결과 저장·공유
* FR-11 조건 변경 및 재추천

### Non-Functional Requirements

* 반응형 UI
* 데이터 최신성
* 응답 성능
* 직관적인 UX
* 데이터 보안 및 개인정보보호
* AI 추천 안정성
* 지역 확장이 가능한 구조

---

## 👥 Team NOVA

| 이름  | 역할                     |
| --- | ---------------------- |
| 박근영 | PM / Team Leader       |
| 김다은 | AI · RAG               |
| 조하은 | Data · DB              |
| 이은주 | Backend                |
| 김보미 | Frontend · UI          |
| 이순덕 | Admin · Dashboard · QA |

---

## 🚀 Development Roadmap

### Phase 1. 기획

* [x] 프로젝트 주제 선정
* [x] 요구사항 정의
* [x] 서비스 구조 설계
* [x] 사용자 흐름 설계
* [x] UI/UX 방향 설정

### Phase 2. Prototype

* [x] 통합 HTML 프로토타입
* [x] 주요 화면 구현
* [x] 사용자 입력 흐름 구현
* [x] 추천 결과 UI 구현

### Phase 3. Data

* [ ] 목포 로컬 데이터 수집
* [ ] 공공데이터 수집
* [ ] 크롤링 데이터 확보
* [ ] 데이터 정제 및 검증
* [ ] Local DB 설계 및 구축
* [ ] 현지인 선택 데이터 반영

### Phase 4. AI / RAG

* [ ] 자연어 Context 추출
* [ ] 사용자 조건 구조화
* [ ] Local DB Retrieval
* [ ] RAG Pipeline 구축
* [ ] 조건 필터링
* [ ] Recommendation Ranking
* [ ] AI Agent 구현
* [ ] 미식 코스 생성

### Phase 5. Web Integration

* [ ] FastAPI Backend
* [ ] Frontend 연동
* [ ] AI API 연동
* [ ] 지도 API 연동
* [ ] 추천 저장 / 공유
* [ ] 사용자 피드백 연동

### Phase 6. Test & Improvement

* [ ] 추천 결과 정확도 테스트
* [ ] 데이터 최신성 검증
* [ ] 응답 성능 개선
* [ ] UX 개선
* [ ] 오류 및 예외 처리
* [ ] 최종 서비스 검증

---

## 📈 Expected Effect

본 서비스는 사용자의 **검색 및 비교에 필요한 시간을 줄이고**, 시간·예산·동행·이동수단·취향을 반영한 개인 맞춤형 목포 먹거리 경험을 제공하는 것을 목표로 합니다.

또한 구축된 목포 먹거리 데이터를 지속적으로 관리·축적하여 향후 **목포를 넘어 다른 지역으로 확장 가능한 로컬 AI 서비스 기반**을 마련하고자 합니다.

---

## 🔮 Future Expansion

### Local → Regional

```text
목포
 ↓
전남
 ↓
지역별 Local DB
 ↓
Regional AI Agent
```

향후 지역별 Local DB를 구축하고 AI Agent와 연결하여 다양한 지역의 관광·미식 추천 서비스로 확장할 수 있습니다.

---

## 📌 Project Status

**Current Status: Prototype / Development**

현재는 서비스의 사용자 경험과 전체 서비스 흐름을 검증하기 위한 프로토타입을 구현한 단계입니다.

앞으로 다음 단계에서는

**Local Data → DB → RAG → AI Agent → Web/API 연동**

순서로 실제 서비스를 구현할 예정입니다.

---

## 🏷️ Keywords

`#Mokpo` `#LocalAI` `#AITravel` `#FoodRecommendation` `#LLM` `#RAG` `#LangChain` `#AIAgent` `#FastAPI` `#Python` `#NLP` `#LocalDB` `#RecommendationSystem`

---

## 👨‍💻 Team

**TEAM NOVA**

> 오늘 내가 남긴 목포의 기록이
> 내일의 여행을 더 좋게.
