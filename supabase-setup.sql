-- Supabase 테이블 생성 SQL
-- Supabase 대시보드의 SQL Editor에서 실행하세요

-- memos 테이블 생성
CREATE TABLE IF NOT EXISTS memos (
    id SERIAL PRIMARY KEY,
    password VARCHAR(255) NOT NULL UNIQUE,
    content TEXT,
    duration_minutes INTEGER DEFAULT 30,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    last_updated TIMESTAMPTZ DEFAULT NOW(),
    expires_at TIMESTAMPTZ
);

-- 인덱스 생성 (성능 최적화) - IF NOT EXISTS는 지원하지 않으므로 DROP 후 생성
DROP INDEX IF EXISTS idx_memos_password;
DROP INDEX IF EXISTS idx_memos_expires_at;

CREATE INDEX idx_memos_password ON memos(password);
CREATE INDEX idx_memos_expires_at ON memos(expires_at);

-- Row Level Security (RLS) 비활성화 (간단한 앱이므로)
ALTER TABLE memos DISABLE ROW LEVEL SECURITY;

-- 만료된 메모 자동 삭제 함수
CREATE OR REPLACE FUNCTION delete_expired_memos()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM memos WHERE expires_at < NOW();
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 자동 삭제 설정 (pg_cron 사용)
-- ============================================
-- 1. pg_cron 확장 활성화 (한 번만 실행)
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- 2. 기존 스케줄이 있다면 삭제
SELECT cron.unschedule('delete-expired-memos');

-- 3. 5분마다 만료된 메모 자동 삭제
SELECT cron.schedule(
    'delete-expired-memos',           -- 작업 이름
    '*/5 * * * *',                    -- 5분마다 실행 (크론 표현식)
    'SELECT delete_expired_memos();'  -- 실행할 SQL
);

-- 스케줄 확인 (선택사항)
-- SELECT * FROM cron.job;
