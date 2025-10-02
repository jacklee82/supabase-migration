# Supabase Migration

SQLite to Supabase migration scripts for profit-loss-management project.

## Features

- SQLite 데이터 추출
- Supabase 테이블 생성
- 데이터 마이그레이션
- CSV 변환 스크립트
- 자동화된 마이그레이션

## Usage

1. Supabase 프로젝트 설정
2. 환경 변수 설정
3. 마이그레이션 실행

## Files

- `migrate_to_supabase.py` - PostgreSQL 직접 연결 마이그레이션
- `migrate_to_supabase_api.py` - Supabase API 마이그레이션
- `export_to_csv.py` - CSV 변환 스크립트
- `manual_migration_guide.md` - 수동 마이그레이션 가이드
- `SUPABASE_MIGRATION_GUIDE.md` - 상세 가이드

## Quick Start

```bash
# CSV 변환 (가장 안정적)
python export_to_csv.py

# Supabase SQL Editor에서 테이블 생성 후
# Table Editor에서 CSV 업로드
```

## Project Info

- **Supabase URL**: https://xiwcqwsyplykpixsszlb.supabase.co
- **Tables**: mapping_table, plan_table, actual_table
- **Total Records**: 3,822 rows