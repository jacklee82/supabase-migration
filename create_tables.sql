-- Supabase SQL Editor에서 실행할 테이블 생성 스크립트
-- Copy and paste this into Supabase SQL Editor

-- 테이블 생성
CREATE TABLE IF NOT EXISTS mapping_table (
    id SERIAL PRIMARY KEY,
    account VARCHAR(20) NOT NULL,
    category VARCHAR(20) NOT NULL,
    business_model VARCHAR(50) NOT NULL,
    item VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS plan_table (
    id SERIAL PRIMARY KEY,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    account VARCHAR(20) NOT NULL,
    category VARCHAR(20) NOT NULL,
    business_model VARCHAR(50) NOT NULL,
    item VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    amount NUMERIC(15, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS actual_table (
    id SERIAL PRIMARY KEY,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    account VARCHAR(20) NOT NULL,
    category VARCHAR(20) NOT NULL,
    business_model VARCHAR(50) NOT NULL,
    item VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    amount NUMERIC(15, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_mapping_account ON mapping_table(account);
CREATE INDEX IF NOT EXISTS idx_mapping_category ON mapping_table(category);
CREATE INDEX IF NOT EXISTS idx_mapping_bm ON mapping_table(business_model);

CREATE INDEX IF NOT EXISTS idx_plan_year_month ON plan_table(year, month);
CREATE INDEX IF NOT EXISTS idx_plan_account ON plan_table(account);
CREATE INDEX IF NOT EXISTS idx_plan_category ON plan_table(category);
CREATE INDEX IF NOT EXISTS idx_plan_bm ON plan_table(business_model);

CREATE INDEX IF NOT EXISTS idx_actual_year_month ON actual_table(year, month);
CREATE INDEX IF NOT EXISTS idx_actual_account ON actual_table(account);
CREATE INDEX IF NOT EXISTS idx_actual_category ON actual_table(category);
CREATE INDEX IF NOT EXISTS idx_actual_bm ON actual_table(business_model);

-- 테이블 생성 확인
SELECT 'Tables created successfully!' as status;
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE' ORDER BY table_name;