# 📝 기획발표 심사 피드백 및 개선 방향

## 📅 발표일

2026-09-04

## 📌 문서 목적

기획발표 과정에서 받은 심사 피드백을 정리하고,
향후 「오늘 뭐 목포?」 추천 시스템의 실제 개발 방향에 반영한다.

---

# 1. 코스 생성 기준

## Feedback

코스 생성 시 시간과 거리 중 어떤 기준을 우선하는지에 대한 질문이 있었다.

시간만을 기준으로 장소를 배치할 경우
실제 이동 경로가 비효율적으로 구성될 가능성이 있다.

## Decision

코스 생성은 단일 기준이 아니라
다단계 우선순위 구조로 설계한다.

### Priority 1 — Hard Constraint

- 영업시간
- 예약시간
- 휴무 여부
- 사용 가능 시간
- 예산

### Priority 2 — Route Efficiency

- 장소 간 거리
- 예상 이동시간
- 이동수단
- 경로 API 결과

### Priority 3 — Context Fit

- 음식 취향
- 동행자
- 분위기
- 여행 목적
- 현지인 경험 태그

### 최종 방향

> 시간 제약을 먼저 만족시키고,
> 그 안에서 이동시간을 최소화하면서
> Context 적합도가 높은 장소를 배치한다.

---

# 2. SQL Hard Filter + RAG 분리

## Feedback

모든 정보를 Vector DB / RAG로 처리하는 것은
정확성 측면에서 적합하지 않다.

가격, 영업시간 등의 정확한 조건은
정형 데이터 기반으로 처리할 필요가 있다.

## Decision

### SQL / DB Hard Filtering

다음 데이터는 SQL 조건 검색으로 처리한다.

- 가격
- 영업시간
- 휴무일
- 위치
- 카테고리
- 주차 여부
- 예약 여부
- 예상 체류시간
- 예산

### Vector DB / RAG

다음과 같은 비정형 Context는
Vector Search를 활용한다.

- 조용하게 이야기하기 좋은 장소
- 부모님과 방문하기 좋은 장소
- 혼자 방문하기 좋은 장소
- 오래 머물기 좋은 카페
- 노을을 보며 걷기 좋은 장소

---

# 3. 추천과 동선 최적화 분리

## Feedback

좋은 장소를 추천하는 것과
좋은 여행 코스를 만드는 것은 다른 문제이다.

## Decision

추천 Pipeline을 다음과 같이 분리한다.

```text
User Context
     ↓
Context Extraction
     ↓
SQL Hard Filtering
     ↓
RAG Retrieval
     ↓
Context Ranking
     ↓
Candidate Selection
     ↓
Route API
     ↓
Course Optimization
     ↓
LLM Explanation
