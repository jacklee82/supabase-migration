"""
SQLite 데이터를 CSV로 변환하는 스크립트
"""
import sqlite3
import csv

def export_to_csv():
    """SQLite 데이터를 CSV 파일로 변환"""
    conn = sqlite3.connect('profit_loss.db')
    cursor = conn.cursor()
    
    tables = ['mapping_table', 'plan_table', 'actual_table']
    
    for table_name in tables:
        print(f"📤 {table_name} 데이터 추출 중...")
        
        cursor.execute(f"SELECT * FROM {table_name}")
        rows = cursor.fetchall()
        
        # 컬럼명 가져오기
        cursor.execute(f"PRAGMA table_info({table_name})")
        columns = [col[1] for col in cursor.fetchall()]
        
        # CSV 파일 생성
        csv_filename = f"{table_name}.csv"
        with open(csv_filename, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow(columns)  # 헤더
            writer.writerows(rows)    # 데이터
        
        print(f"✅ {csv_filename} 생성 완료 ({len(rows)} rows)")
    
    conn.close()
    print("\n🎉 모든 CSV 파일 생성 완료!")
    print("\n📋 다음 단계:")
    print("1. Supabase 대시보드 → SQL Editor에서 테이블 생성")
    print("2. Supabase 대시보드 → Table Editor에서 CSV 업로드")

if __name__ == "__main__":
    export_to_csv()