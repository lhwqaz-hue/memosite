# Supabase 자동 삭제 설정 가이드

## 설정 방법

### 1. SQL 실행
Supabase Dashboard > SQL Editor에서 `supabase-setup.sql` 파일의 내용을 실행하세요.

이제 **5분마다 자동으로 만료된 메모가 삭제**됩니다!

### 2. 확인 방법

#### 스케줄 확인:
```sql
SELECT * FROM cron.job;
```

#### 수동 실행 테스트:
```sql
SELECT delete_expired_memos();
```
반환 값이 삭제된 메모의 개수입니다.

## 설정 변경

### 삭제 주기 변경
크론 표현식을 수정하여 주기를 변경할 수 있습니다:

```sql
-- 기존 스케줄 삭제
SELECT cron.unschedule('delete-expired-memos');

-- 새 스케줄 등록
SELECT cron.schedule(
    'delete-expired-memos',
    '*/10 * * * *',  -- 10분마다
    'SELECT delete_expired_memos();'
);
```

### 크론 표현식 예시:
- `*/5 * * * *` : 5분마다
- `*/10 * * * *` : 10분마다
- `0 * * * *` : 매시간 정각
- `0 */2 * * *` : 2시간마다
- `0 0 * * *` : 매일 자정

### 자동 삭제 중지
```sql
SELECT cron.unschedule('delete-expired-memos');
```

## 주의사항

⚠️ **pg_cron은 Supabase 무료 플랜에서도 사용 가능합니다.**

- 자동 삭제는 서버 시간(UTC) 기준으로 동작합니다.
- 데이터베이스 연결이 유지되는 한 계속 실행됩니다.
- 삭제된 데이터는 복구할 수 없습니다.

## 문제 해결

### pg_cron 확장이 없다는 오류가 발생하면:
1. Supabase Dashboard > Database > Extensions 이동
2. `pg_cron` 검색 후 활성화
3. SQL을 다시 실행

### 스케줄이 작동하지 않으면:
```sql
-- 현재 등록된 스케줄 확인
SELECT * FROM cron.job;

-- 실행 로그 확인
SELECT * FROM cron.job_run_details 
ORDER BY start_time DESC 
LIMIT 10;
```
