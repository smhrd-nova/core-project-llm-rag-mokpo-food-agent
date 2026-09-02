# Web Integration Development Log

## 2026-09-02

### 1. 개발 목적

기존 HTML 기반 TEAM NOVA 프로토타입을 실제 웹서비스 형태로
실행하기 위한 Backend 구조를 구축하였다.

### 2. 개발 내용

- 기존 TEAM NOVA Frontend 유지
- Node.js 환경 구축
- Express Backend 구축
- Frontend ↔ Backend API 구조 설계
- Demo 관광 데이터 분리
- Local 환경에서 웹서비스 실행 확인

### 3. 현재 구조

Frontend
↓
Express Backend
↓
Demo Data

### 4. API

GET /api/health
GET /api/places

POST /api/recommend
POST /api/chat
POST /api/rag/query

### 5. AI/RAG 연동 준비

현재 AI 및 RAG는 연결하지 않고 API 인터페이스만 구성하였다.

향후:

User
↓
LLM
↓
Context Extraction
↓
RAG
↓
Local DB
↓
Tavily Search
↓
Recommendation
↓
Frontend

구조로 확장할 예정이다.

### 6. 현재 상태

- [x] Frontend Prototype
- [x] Node.js 환경
- [x] Express Backend
- [x] API 구조
- [x] Local 실행
- [ ] 실제 관광 데이터
- [ ] Tavily Search
- [ ] LLM
- [ ] RAG
- [ ] Vector DB
- [ ] 지도 API
- [ ] Web Deployment
