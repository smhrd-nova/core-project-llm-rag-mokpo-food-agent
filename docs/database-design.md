# Database Design

## 설계 목적

NOVA 프로젝트의 여행 추천 서비스를 위해 사용자, 장소(POI), 여행, 리뷰, 커뮤니티, 쿠폰, 스탬프, 추천 결과 등의 데이터를 기능별 테이블로 분리했습니다.

## 핵심 설계 원칙

1. 장소 데이터는 `tb_poi`에서 단일 관리
2. 장소 분류는 `tb_category`에서 관리
3. 태그는 `tb_tag`로 분리하여 장소와 리뷰에 재사용
4. N:M 관계는 중간 테이블로 분리
5. 사용자와 여행/리뷰/즐겨찾기 데이터의 관계를 FK로 관리
6. 추천 결과는 원본 장소와 분리하여 `tb_recommendation`에서 관리
7. 외부 검색으로 검증되지 않은 장소 속성은 NULL 허용
8. 시간 정보는 PostgreSQL `TIMESTAMPTZ`를 사용하여 시간대 정보를 보존

## ERD 기준 주요 연결

```text
tb_category
    │
    └──< tb_poi
           ├──< tb_running_time
           ├──< tb_coupon
           ├──< tb_favorite
           ├──< tb_poi_mapping >── tb_tag
           ├──< tb_recommendation >── tb_room
           └──< tb_stamp >──< tb_user_stamp >── tb_user

tb_user
    ├──< tb_review >──< tb_review_tag >── tb_tag
    ├──< tb_trip
    │      └──< tb_trip_log
    ├──< tb_room
    │      └──< tb_chat
    ├──< tb_user_coupon >── tb_coupon
    └──< tb_prompt
```

## 주의사항

이 문서는 제공된 ERD 이미지에서 확인 가능한 테이블명/컬럼명/관계를 기반으로 GitHub 기록용으로 정리한 것입니다.

ERD 이미지에서 실제 PostgreSQL의 정확한 데이터 타입이나 제약조건명이 표시되지 않는 항목은 프로젝트 DB의 실제 DDL과 배포 전에 대조해야 합니다.
