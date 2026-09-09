# NOVA 프로젝트 Database

목포·남악 지역의 관광지, 음식점, 카페 정보를 기반으로 여행 추천과 일정 관리, 리뷰, 즐겨찾기, 쿠폰, 스탬프, 커뮤니티 기능 등을 제공하기 위한 PostgreSQL 데이터베이스입니다.

## 1. Database Overview

ERD를 기준으로 기능별 데이터를 분리하고 PK/FK 관계를 통해 데이터 무결성을 유지하도록 설계했습니다.

### 주요 기능

- POI(관광지/음식점/카페) 관리
- 카테고리 및 해시태그 관리
- 운영시간 관리
- 쿠폰 관리
- 사용자 리뷰 및 리뷰 태그
- 즐겨찾기
- 여행 일정 및 여행 기록
- 여행 사진
- AI 기반 장소 추천
- 여행방/채팅
- 여행 기록 공유
- 스탬프 및 리워드
- 사용자 맞춤형 AI 프롬프트 저장

## 2. Table List

| Table | Purpose |
|---|---|
| `tb_user` | 사용자 기본 정보 |
| `tb_category` | POI 카테고리 |
| `tb_poi` | 관광지/음식점/카페 장소 정보 |
| `tb_tag` | 장소/리뷰 태그 |
| `tb_poi_mapping` | POI와 태그의 N:M 연결 |
| `tb_running_time` | 장소 운영시간 |
| `tb_coupon` | 장소 쿠폰 |
| `tb_user_coupon` | 사용자별 쿠폰 발급/사용 |
| `tb_review` | 사용자 리뷰 |
| `tb_review_tag` | 리뷰와 태그 연결 |
| `tb_favorite` | 사용자 즐겨찾기 |
| `tb_photo` | 여행/장소 사진 |
| `tb_trip` | 여행 기본 정보 |
| `tb_schedule` | 여행 일정 |
| `tb_trip_log` | 여행 기록/코스 |
| `tb_room` | 여행 커뮤니티 방 |
| `tb_chat` | 여행방 채팅 |
| `tb_share` | 여행 기록 공유 |
| `tb_recommendation` | AI/추천 결과 |
| `tb_stamp` | 장소 스탬프 |
| `tb_user_stamp` | 사용자 스탬프 획득 정보 |
| `tb_prompt` | AI 여행 추천 요청 |

## 3. POI Category

`tb_poi.category_id`는 프로젝트에서 다음과 같이 사용합니다.

| category_id | category_name |
|---:|---|
| 2 | 관광지 |
| 3 | 음식점 |
| 4 | 카페 |

## 4. 핵심 테이블: tb_poi

`tb_poi`는 프로젝트의 장소 데이터를 저장하는 핵심 테이블입니다.

| Column | Type | Nullable | Description |
|---|---|---|---|
| `poi_id` | BIGINT | NO | 장소 식별자 |
| `category_id` | INTEGER | NO | 장소 카테고리 |
| `poi_name` | VARCHAR | NO | 장소명 |
| `description` | TEXT | NO | 장소 설명/태그 |
| `address` | VARCHAR | YES | 주소 |
| `lat` | NUMERIC | YES | 위도 |
| `lon` | NUMERIC | YES | 경도 |
| `phone` | VARCHAR | YES | 전화번호 |
| `price_level` | VARCHAR | YES | 가격대 |
| `reservation_required` | BOOLEAN | YES | 예약 필요 여부 |
| `parking_available` | BOOLEAN | YES | 주차 가능 여부 |
| `source_type` | VARCHAR | NO | 데이터 출처 유형 |
| `external_url` | TEXT | YES | 외부 상세 페이지 |
| `is_active` | BOOLEAN | NO | 활성 상태 |
| `last_verified_at` | TIMESTAMPTZ | YES | 마지막 검증 시각 |
| `created_at` | TIMESTAMPTZ | NO | 생성 시각 |
| `update_at` | TIMESTAMPTZ | NO | 수정 시각 |

## 5. Relationship

주요 관계는 다음과 같습니다.

- `tb_category` 1 : N `tb_poi`
- `tb_poi` N : M `tb_tag` → `tb_poi_mapping`
- `tb_poi` 1 : N `tb_running_time`
- `tb_poi` 1 : N `tb_coupon`
- `tb_user` 1 : N `tb_review`
- `tb_review` N : M `tb_tag` → `tb_review_tag`
- `tb_user` N : M `tb_poi` → `tb_favorite`
- `tb_user` N : M `tb_coupon` → `tb_user_coupon`
- `tb_user` 1 : N `tb_trip`
- `tb_trip` 1 : N `tb_trip_log`
- `tb_room` 1 : N `tb_chat`
- `tb_room` 1 : N `tb_recommendation`
- `tb_poi` 1 : N `tb_recommendation`
- `tb_poi` 1 : N `tb_stamp`
- `tb_user` N : M `tb_stamp` → `tb_user_stamp`

## 6. Data Import

POI 데이터는 CSV를 이용하여 PostgreSQL에 적재합니다.

```sql
COPY tb_poi (
    poi_id,
    category_id,
    poi_name,
    description,
    address,
    lat,
    lon,
    phone,
    price_level,
    reservation_required,
    parking_available,
    source_type,
    external_url,
    is_active,
    last_verified_at,
    created_at,
    update_at
)
FROM '/path/to/tb_poi_mokpo_namak_verified.csv'
WITH (
    FORMAT csv,
    HEADER true,
    ENCODING 'UTF8'
);
```

> PostgreSQL 서버에서 직접 `COPY`를 실행하는 경우 CSV 경로는 서버가 접근 가능한 실제 경로여야 합니다.  
> 로컬 PC에서 pgAdmin으로 가져오는 경우에는 Import/Export 기능을 사용할 수 있습니다.

## 7. Repository Structure

권장 GitHub 구조:

```text
database/
├── README.md
├── schema/
│   └── nova.sql
├── docs/
│   └── database-design.md
└── data/
    └── tb_poi_mokpo_namak_verified.csv
```

## 8. Data Quality

POI 데이터는 장소명, 주소, 좌표, 카테고리 및 외부 정보를 기준으로 중복/유효성을 검토하고 구축했습니다.

`price_level`, `reservation_required`, `parking_available`과 같이 외부 검색이 필요한 값은 확인 가능한 근거가 없는 경우 NULL을 허용하는 것을 원칙으로 합니다.

즉, **확인되지 않은 정보를 추정하여 채우지 않는 것**을 데이터 품질 원칙으로 합니다.
