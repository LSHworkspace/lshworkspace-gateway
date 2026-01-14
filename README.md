# LSHworkspace Gateway

LSHworkspace 인프라를 위한 Nginx 리버스 프록시 게이트웨이입니다.

## 개요

Docker Swarm 환경에서 운영되는 중앙 집중식 리버스 프록시로, 여러 서비스에 대한 트래픽 라우팅 및 SSL 종료를 담당합니다.

## 기술 스택

- **Nginx 1.27.5** - 고성능 웹 서버 및 리버스 프록시
- **Docker Swarm** - 컨테이너 오케스트레이션
- **GitHub Actions** - CI/CD 파이프라인

## 프로젝트 구조

```
.
├── Dockerfile                 # Nginx 컨테이너 빌드 설정
├── docker-entrypoint.sh       # 컨테이너 시작 스크립트
├── nginx/
│   ├── nginx.conf             # Nginx 메인 설정
│   ├── conf.d/                # 가상 호스트 설정
│   │   ├── default.conf
│   │   ├── lshworkspace.com.conf
│   │   ├── junartstory.com.conf
│   │   ├── registry.lshworkspace.com.conf
│   │   └── pgadmin.lshworkspace.com.conf
│   └── snippets/              # 재사용 가능한 설정 조각
│       └── global-error-pages.conf
├── share/                     # 정적 웹사이트 파일
│   ├── html/                  # 공통 HTML
│   ├── maintenance/           # 점검 페이지
│   ├── junartstory/           # junartstory.com 사이트
│   └── static/                # 공유 정적 에셋
├── static/
│   └── errors/                # 에러 페이지
└── .github/workflows/         # CI/CD 워크플로우
```

## 호스팅 서비스

| 도메인 | 설명 |
|--------|------|
| `lshworkspace.com` | 메인 워크스페이스 서비스 |
| `junartstory.com` | 포트폴리오 웹사이트 |
| `registry.lshworkspace.com` | 프라이빗 Docker 레지스트리 |
| `pgadmin.lshworkspace.com` | PostgreSQL 관리 인터페이스 |

## 배포

### 사전 요구사항

1. Docker Swarm 클러스터 초기화
2. 오버레이 네트워크 생성
3. Docker Hub 로그인

### 네트워크 설정

```bash
docker network create --attachable --driver overlay lshworkspace-proxy
```

### Docker Hub 로그인

```bash
docker login
```

### 수동 배포

```bash
docker build -t lshworkspace/gateway .
docker push lshworkspace/gateway
docker service update --image lshworkspace/gateway gateway
```

### 자동 배포

`release` 브랜치에 push하면 GitHub Actions를 통해 자동으로 빌드 및 배포됩니다.

## Docker Swarm 노드 관리

### 매니저 노드 라벨 설정

```bash
docker node update --label-add manager lshworkspace-m00
```

### 서비스 상태 확인

```bash
docker service ls
docker service logs gateway
```

## 점검 모드

서비스 점검 시 `share/maintenance/index.html`이 표시됩니다.

## 브랜치 전략

Git Flow 브랜칭 모델을 따릅니다:

- `main` - 프로덕션 배포 브랜치
- `release` - 릴리스 준비 브랜치
- `development` - 개발 및 기능 통합 브랜치

## 라이선스

Private Repository
