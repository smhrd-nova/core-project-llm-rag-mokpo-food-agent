-- ============================================================
-- NOVA Project PostgreSQL Database Schema
-- ERD 기준 테이블/컬럼 정의
-- Generated for GitHub documentation
-- ============================================================

-- 주의:
-- 1. 기존 DB의 실제 타입/제약조건과 ERD의 아이콘을 기준으로 작성한 스키마 문서용 SQL입니다.
-- 2. ERD에서 확인되는 관계를 FK로 정의했습니다.
-- 3. 실제 운영 DB에 적용하기 전 기존 DB의 PK/FK 이름 및 타입과 1회 대조하세요.

-- ------------------------------------------------------------
-- 1. User / Category / POI
-- ------------------------------------------------------------

CREATE TABLE tb_user (
    user_id BIGINT PRIMARY KEY,
    nickname VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    login_provider VARCHAR NOT NULL,
    profile_image TEXT,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE tb_category (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR NOT NULL,
    is_active BOOLEAN NOT NULL
);

CREATE TABLE tb_poi (
    poi_id BIGINT PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES tb_category(category_id),
    poi_name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    address VARCHAR,
    lat NUMERIC,
    lon NUMERIC,
    phone VARCHAR,
    price_level VARCHAR,
    reservation_required BOOLEAN,
    parking_available BOOLEAN,
    source_type VARCHAR NOT NULL,
    external_url TEXT,
    is_active BOOLEAN NOT NULL,
    last_verified_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL,
    update_at TIMESTAMPTZ NOT NULL
);

-- ------------------------------------------------------------
-- 2. Tag / POI mapping / Running time / Coupon
-- ------------------------------------------------------------

CREATE TABLE tb_tag (
    tag_id BIGINT PRIMARY KEY,
    tag_name VARCHAR NOT NULL,
    tag_type VARCHAR NOT NULL,
    is_active BOOLEAN NOT NULL
);

CREATE TABLE tb_poi_mapping (
    mapping_id BIGINT PRIMARY KEY,
    poi_id BIGINT NOT NULL REFERENCES tb_poi(poi_id),
    tag_id BIGINT NOT NULL REFERENCES tb_tag(tag_id)
);

CREATE TABLE tb_running_time (
    running_id BIGINT PRIMARY KEY,
    poi_id BIGINT NOT NULL REFERENCES tb_poi(poi_id),
    day_of_week INTEGER NOT NULL,
    open_time TIME,
    close_time TIME,
    is_closed BOOLEAN,
    break_time VARCHAR,
    verified_at TIMESTAMPTZ
);

CREATE TABLE tb_coupon (
    coupon_id BIGINT PRIMARY KEY,
    poi_id BIGINT NOT NULL REFERENCES tb_poi(poi_id),
    coupon_name VARCHAR NOT NULL,
    discount_type VARCHAR NOT NULL,
    discount_value NUMERIC,
    st_dt TIMESTAMPTZ,
    ed_dt TIMESTAMPTZ,
    is_used BOOLEAN,
    is_active BOOLEAN,
    created_at TIMESTAMPTZ,
    coupon_type VARCHAR
);

-- ------------------------------------------------------------
-- 4. Trip / Schedule / Trip log
-- ------------------------------------------------------------

CREATE TABLE tb_trip (
    trip_id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES tb_user(user_id),
    trip_title VARCHAR,
    trip_type VARCHAR,
    st_date DATE,
    ed_date DATE
);

CREATE TABLE tb_schedule (
    sch_id BIGINT PRIMARY KEY,
    tour_date DATE,
    st_time TIME,
    poi_id BIGINT REFERENCES tb_poi(poi_id),
    selection_type VARCHAR,
    "order" INTEGER,
    visit_yn BOOLEAN
);

CREATE TABLE tb_trip_log (
    course_id BIGINT PRIMARY KEY,
    trip_id BIGINT NOT NULL REFERENCES tb_trip(trip_id),
    user_id BIGINT NOT NULL REFERENCES tb_user(user_id),
    title VARCHAR,
    content TEXT,
    access_scope VARCHAR,
    share_slug VARCHAR,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);



CREATE TABLE tb_photo (
    photo_id BIGINT PRIMARY KEY,
    course_id BIGINT REFERENCES tb_trip_log(course_id),
    poi_id BIGINT REFERENCES tb_poi(poi_id),
    file_name VARCHAR,
    file_ext VARCHAR,
    file_size NUMERIC,
    display_order INTEGER,
    created_at TIMESTAMPTZ,
    access_scope VARCHAR
);

-- ------------------------------------------------------------
-- Review / Favorite / User coupon / Photo
-- ------------------------------------------------------------

CREATE TABLE tb_review (
    review_id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES tb_user(user_id),
    trip_id BIGINT REFERENCES tb_trip(trip_id),
    ratings NUMERIC,
    review_content TEXT,
    revisit_intent BOOLEAN,
    visited_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ
);

CREATE TABLE tb_review_tag (
    review_tag_id BIGINT PRIMARY KEY,
    review_id BIGINT NOT NULL REFERENCES tb_review(review_id),
    tag_id BIGINT NOT NULL REFERENCES tb_tag(tag_id),
    confidence NUMERIC
);

CREATE TABLE tb_favorite (
    favorite_id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES tb_user(user_id),
    poi_id BIGINT NOT NULL REFERENCES tb_poi(poi_id),
    created_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE tb_user_coupon (
    user_coupon_id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES tb_user(user_id),
    coupon_id BIGINT NOT NULL REFERENCES tb_coupon(coupon_id),
    issued_at TIMESTAMPTZ,
    used_at TIMESTAMPTZ
);

-- ------------------------------------------------------------
-- 5. Room / Chat / Share
-- ------------------------------------------------------------

CREATE TABLE tb_room (
    room_id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES tb_user(user_id),
    room_title VARCHAR,
    room_desc TEXT,
    room_limit INTEGER,
    room_status VARCHAR,
    created_at TIMESTAMPTZ
);

CREATE TABLE tb_chat (
    chat_id BIGINT PRIMARY KEY,
    room_id BIGINT NOT NULL REFERENCES tb_room(room_id),
    chatter VARCHAR,
    chat_content TEXT,
    chat_emoticon VARCHAR,
    chat_file TEXT,
    created_at TIMESTAMPTZ
);

CREATE TABLE tb_share (
    share_id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES tb_user(user_id),
    trip_log_id BIGINT NOT NULL REFERENCES tb_trip_log(course_id),
    platform VARCHAR,
    share_url TEXT,
    is_public BOOLEAN,
    view_count INTEGER,
    click_count INTEGER,
    shared_at TIMESTAMPTZ
);

-- ------------------------------------------------------------
-- 6. Recommendation
-- ------------------------------------------------------------

CREATE TABLE tb_recommendation (
    recommendation_place_id BIGINT PRIMARY KEY,
    room_id BIGINT NOT NULL REFERENCES tb_room(room_id),
    place_id BIGINT NOT NULL REFERENCES tb_poi(poi_id),
    filter_passed BOOLEAN,
    context_score NUMERIC,
    distance_score NUMERIC,
    experience_score NUMERIC,
    final_score NUMERIC,
    rank_order INTEGER,
    recommendation_reason TEXT
);

-- ------------------------------------------------------------
-- 7. Stamp
-- ------------------------------------------------------------

CREATE TABLE tb_stamp (
    stamp_id BIGINT PRIMARY KEY,
    place_id BIGINT NOT NULL REFERENCES tb_poi(poi_id),
    stamp_name VARCHAR,
    stamp_description TEXT,
    verification_type VARCHAR,
    reward_point INTEGER,
    is_used BOOLEAN,
    created_at TIMESTAMPTZ
);

CREATE TABLE tb_user_stamp (
    user_stamp_id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES tb_user(user_id),
    stamp_id BIGINT NOT NULL REFERENCES tb_stamp(stamp_id),
    get_at TIMESTAMPTZ,
    verification_type VARCHAR,
    status VARCHAR,
    verification_data TEXT,
    reward_point INTEGER,
    is_used BOOLEAN,
    created_at TIMESTAMPTZ
);

-- ------------------------------------------------------------
-- 8. AI Prompt
-- ------------------------------------------------------------

CREATE TABLE tb_prompt (
    prompt_id BIGINT PRIMARY KEY,
    user_id BIGINT REFERENCES tb_user(user_id),
    party_type VARCHAR,
    party_size INTEGER,
    budget NUMERIC,
    transport_type VARCHAR,
    st_dt TIMESTAMPTZ,
    ed_dt TIMESTAMPTZ,
    activity_level VARCHAR,
    raw_request TEXT,
    created_at TIMESTAMPTZ
);

-- ------------------------------------------------------------
-- Indexes
-- ------------------------------------------------------------

CREATE INDEX idx_tb_poi_category_id
    ON tb_poi(category_id);

CREATE INDEX idx_tb_poi_location
    ON tb_poi(lat, lon);

CREATE INDEX idx_tb_poi_mapping_poi_id
    ON tb_poi_mapping(poi_id);

CREATE INDEX idx_tb_poi_mapping_tag_id
    ON tb_poi_mapping(tag_id);

CREATE INDEX idx_tb_review_user_id
    ON tb_review(user_id);

CREATE INDEX idx_tb_review_trip_id
    ON tb_review(trip_id);

CREATE INDEX idx_tb_favorite_user_id
    ON tb_favorite(user_id);

CREATE INDEX idx_tb_favorite_poi_id
    ON tb_favorite(poi_id);

CREATE INDEX idx_tb_trip_user_id
    ON tb_trip(user_id);

CREATE INDEX idx_tb_trip_log_trip_id
    ON tb_trip_log(trip_id);

CREATE INDEX idx_tb_recommendation_room_id
    ON tb_recommendation(room_id);

CREATE INDEX idx_tb_recommendation_place_id
    ON tb_recommendation(place_id);

CREATE INDEX idx_tb_chat_room_id
    ON tb_chat(room_id);

CREATE INDEX idx_tb_user_stamp_user_id
    ON tb_user_stamp(user_id);

CREATE INDEX idx_tb_user_stamp_stamp_id
    ON tb_user_stamp(stamp_id);

-- ------------------------------------------------------------
-- Category seed
-- 프로젝트에서 확정한 POI category_id
-- ------------------------------------------------------------

INSERT INTO tb_category (category_id, category_name, is_active)
VALUES
    (2, '관광지', TRUE),
    (3, '음식점', TRUE),
    (4, '카페', TRUE)
ON CONFLICT (category_id) DO NOTHING;
