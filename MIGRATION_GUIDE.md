# Supabase 마이그레이션 가이드

## 🎯 목표
SQLite 데이터베이스를 Supabase PostgreSQL로 마이그레이션

## 📊 현재 데이터 현황
- **mapping_table**: 26 rows
- **plan_table**: 1,898 rows  
- **actual_table**: 1,898 rows
- **총 레코드**: 3,822개

## 🚀 마이그레이션 방법 (권장)

### 방법 1: CSV 변환 + 수동 업로드 (가장 안정적)

#### 1단계: CSV 데이터 추출
```bash
cd backend
python export_to_csv.py
```

생성되는 파일:
- `mapping_table.csv`
- `plan_table.csv`
- `actual_table.csv`

#### 2단계: Supabase 테이블 생성
1. **Supabase 대시보드** → **SQL Editor**
2. `create_tables.sql` 파일 내용을 복사하여 실행
3. 테이블 생성 확인

#### 3단계: CSV 데이터 업로드
1. **Supabase 대시보드** → **Table Editor**
2. 각 테이블 클릭:
   - `mapping_table` → **Insert** → **Upload CSV**
   - `plan_table` → **Insert** → **Upload CSV**
   - `actual_table` → **Insert** → **Upload CSV**
3. 생성된 CSV 파일 업로드

#### 4단계: 백엔드 연결 설정
```python
# backend/app/database.py
USE_SUPABASE = True
```

환경 변수 설정:
```bash
$env:USE_SUPABASE="true"
$env:SUPABASE_URL="https://xiwcqwsyplykpixsszlb.supabase.co"
$env:SUPABASE_PASSWORD="0OoEzawRJUR9rUB5"
$env:SUPABASE_DB="postgres"
$env:SUPABASE_USER="postgres"
```

### 방법 2: API 마이그레이션 (고급)

#### 1단계: 의존성 설치
```bash
cd backend
uv sync  # requests 모듈 포함
```

#### 2단계: API 마이그레이션 실행
```bash
uv run python migrate_to_supabase_api.py
```

## 🔧 문제 해결

### 연결 타임아웃 문제
- **원인**: 네트워크 방화벽 또는 Supabase Free 플랜 제한
- **해결**: CSV 변환 방식 사용 (방법 1)

### 권한 문제
- **원인**: RLS(Row Level Security) 설정
- **해결**: Supabase 대시보드에서 RLS 비활성화 또는 정책 설정

### 데이터 타입 오류
- **원인**: SQLite와 PostgreSQL 데이터 타입 차이
- **해결**: 스키마 확인 및 데이터 타입 변환

## ✅ 마이그레이션 완료 확인

### 1. 테이블 확인
```sql
SELECT table_name, table_rows 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;
```

### 2. 데이터 확인
```sql
SELECT COUNT(*) as mapping_count FROM mapping_table;
SELECT COUNT(*) as plan_count FROM plan_table;
SELECT COUNT(*) as actual_count FROM actual_table;
```

### 3. API 테스트
```bash
# 백엔드 서버 시작
cd backend
uv run uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# API 테스트
curl "http://localhost:8000/api/dashboard?year=2025&month=1"
```

## 📋 체크리스트

- [ ] CSV 파일 생성 완료
- [ ] Supabase 테이블 생성 완료
- [ ] CSV 데이터 업로드 완료
- [ ] 백엔드 연결 설정 완료
- [ ] API 테스트 성공
- [ ] 프론트엔드 연결 테스트 성공

## 🎉 완료!

마이그레이션이 완료되면:
- **Supabase PostgreSQL** 데이터베이스 사용
- **실시간 동기화** 지원
- **확장성** 향상
- **AI 호환성** 개선