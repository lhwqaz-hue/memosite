# Phyiv Memo 📝

PC와 모바일 간 간단한 텍스트 공유를 위한 웹 애플리케이션입니다. 로그인 없이 키만으로 메모를 공유할 수 있습니다.

## 주요 기능

- 🔑 **키 기반 공유**: 4자 이상의 간단한 키로 메모 공유
- ⏱️ **유연한 유효시간**: 5분부터 24시간까지 설정 가능 (기본 30분)
- 💾 **실시간 자동 저장**: 0.5초 디바운스로 자동 저장
- 🔍 **강력한 검색**: 실시간 하이라이트 및 키보드 탐색 (↓↑)
- 🌙 **다크모드**: 라이트/다크 테마 지원
- 📱 **모바일 최적화**: 반응형 디자인
- 📊 **글자 수 카운터**: 공백 포함/제외 구분 표시
- 🏠 **로컬 모드**: 키 없이도 로컬 전용으로 사용 가능

## 스크린샷

### 라이트 모드
- 깨끗한 보라색 그라데이션 배경
- 직관적인 UI/UX

### 다크 모드
- 눈이 편안한 어두운 테마
- 모든 UI 요소 자동 조정

## 사용 방법

### 1. 키 설정
1. 웹사이트 접속
2. 팝업 모달에서 "🔑 새 키 설정" 선택
3. 4자 이상의 키 입력
4. 메모 작성 (자동 저장됨)

### 2. 메모 공유
- **PC에서**: 키를 모바일에 전달
- **모바일에서**: 같은 키로 로그인하거나 URL 파라미터 사용
  - 예: `https://your-domain.com?p=나의키`

### 3. 고급 기능
- **검색**: 검색창에 입력 후 ↓↑ 키로 이동
- **유효시간 설정**: 타이머 버튼 클릭하여 5분~24시간 선택
- **테마 전환**: 오른쪽 상단 테마 버튼 (🌙/☀️)
- **로컬 모드**: 키 설정 없이 로컬에서만 사용

## 설치 및 실행

### 필수 요구사항
- Node.js (v14 이상)
- npm 또는 yarn

### 설치
```bash
# 저장소 클론
 git clone https://github.com/lhwqaz-hue/memosite.git
cd memosite

# 의존성 설치
npm install
```

### 실행
```bash
# 프로덕션 모드
npm start

# 개발 모드 (자동 재시작)
npm run dev
```

서버가 시작되면 `http://localhost:3000`에서 접속 가능합니다.

## 기술 스택

### 백엔드
- **Node.js**: 서버 런타임
- **Express**: 웹 프레임워크
- **In-Memory Storage**: 빠른 데이터 접근

### 프론트엔드
- **Vanilla JavaScript**: 프레임워크 없는 순수 JS
- **HTML5 & CSS3**: 표준 웹 기술
- **CSS Variables**: 다이내믹 테마
- **Responsive Design**: 모바일 우선 디자인

## 프로젝트 구조

```
memosite/
├── server.js           # Express 서버 및 API 엔드포인트
├── package.json        # 프로젝트 메타데이터 및 의존성
├── public/             # 정적 파일
│   ├── index.html      # 메인 HTML
│   ├── styles.css      # 스타일시트 (라이트/다크 테마)
│   └── app.js          # 클라이언트 로직
└── README.md           # 프로젝트 문서
```

## API 엔드포인트

### `POST /api/check-password`
키 사용 가능 여부 확인
```json
{
  "password": "키값"
}
```

### `POST /api/memo`
새 메모 생성
```json
{
  "password": "키값",
  "content": "메모 내용"
}
```

### `GET /api/memo/:password`
메모 조회

### `PUT /api/memo/:password`
메모 업데이트 (만료시간 갱신)
```json
{
  "content": "수정된 내용"
}
```

### `DELETE /api/memo/:password`
메모 삭제

## 주의사항

⚠️ **중요**: 이 프로젝트는 교육/테스트 목적으로 제작되었습니다.

- 메모는 서버 메모리에 저장되므로 **서버 재시작 시 모든 데이터가 삭제됩니다**
- 프로덕션 환경에서는 **Redis나 데이터베이스 사용을 권장**합니다
- **민감한 정보는 저장하지 마세요**
- 메모는 마지막 수정 후 설정된 시간 후 자동 삭제됩니다

## 배포

### Heroku
```bash
# Heroku CLI 설치 후
heroku create
git push heroku main
```

### Vercel
```bash
# Vercel CLI 설치 후
vercel
```

### Docker
```dockerfile
FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 기여

버그 리포트, 기능 제안, Pull Request를 환영합니다!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 라이선스

MIT License - 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 제작자

**lhwqaz-hue** - [GitHub](https://github.com/lhwqaz-hue)

## 감사

- Express.js 팀
- Node.js 커뮤니티
- 모든 기여자들
