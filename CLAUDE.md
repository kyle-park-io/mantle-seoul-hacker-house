# mantle-seoul-hacker-house

Mantle 기반 작업을 위한 모노레포. 컨트랙트 개발, 배포된 프로덕션 컨트랙트 분석, 외부 레포 참조를 한 곳에 모은다.

## 최상위 구조

| 폴더             | 성격                   | 설명                                                                                                         |
| ---------------- | ---------------------- | ------------------------------------------------------------------------------------------------------------ |
| `contracts/`     | **프로덕션 레퍼런스**  | 이미 온체인에 배포돼 운영 중인 컨트랙트의 소스/주소/ABI를 끌어와 **분석**하는 곳. 우리가 만든 코드가 아니다. |
| `contracts-dev/` | **개발 워크스페이스**  | 우리가 직접 작성·실험·시뮬레이션하는 코드. Hardhat 3 + Foundry 두 스택.                                      |
| `external/`      | **외부 레포 서브모듈** | 다른 레포를 git submodule로 참조.                                                                            |

> `contracts/` 와 `contracts-dev/` 는 **단계 관계가 아니라 별개**다. dev에서 졸업해 prod로 가는 구조가 아니라, 한쪽은 "남이 배포한 걸 분석", 한쪽은 "우리가 개발"이다.

## 작업 컨벤션

### 커밋 / git

- **커밋은 사람(사용자)이 한다.** 파일 수정과 `git add`(스테이징)까지만 하고, `git commit` 은 하지 않는다. push도 사용자 몫.
- 시크릿(`.env`, private key 등)은 절대 커밋하지 않는다. 외부에서 무언가를 복사해 올 때 `.env` 가 딸려오면 제거하고 `.env.example` 만 남긴다.
- 빌드 산출물(`node_modules`, `out/`, `cache/`, `artifacts/`, foundry `lib/`)은 커밋하지 않는다 — 각 폴더 `.gitignore` 가 처리한다.

### external/ 서브모듈

- 추가: `git submodule add <url> external/<name>`
- 최신화: `git submodule update --remote --merge` 후 `git add external` (커밋은 사용자가).
- 클론 직후 복원: `git submodule update --init --recursive`
- 주의: 서브모듈마다 기본 브랜치가 다를 수 있다 (대부분 `main`, `chains` 는 `master`).

### contracts/ — 프로덕션 컨트랙트 가져오기

배포된 컨트랙트를 분석용으로 들여올 때의 표준 절차 (Aave V3 가 첫 사례, `contracts/aave-v3-mantle/` 참고):

1. **주소는 권위 있는 출처에서.** 추측 금지. Aave는 [aave-address-book](https://github.com/bgd-labs/aave-address-book), 그 외엔 공식 docs/배포 레포.
2. 폴더 구조: `contracts/<protocol>/` 아래 `address.md`, `abi/`, `src/`, `analysis.md`, `README.md`.
3. **ABI/소스 수집**: Mantlescan/Etherscan은 이제 Etherscan V2 통합 API(`chainid=5000`)라 **API 키가 필수**다. 키가 없으면 공식 npm 패키지(`@aave/core-v3` 등)와 GitHub 소스(`aave-v3-origin` 등)에서 받는다.
4. **검증 한계 명시**: 키 없이 받은 ABI/소스는 그 주소의 온체인 바이트코드와 1:1 검증된 게 아니다 — README/analysis 에 그 사실을 적는다.
5. 받은 단일 `.sol` 은 import 의존이 있어 단독 컴파일이 안 될 수 있다. 읽기·분석용임을 명시.

### contracts-dev/ — 개발

- Hardhat: `cd contracts-dev/hardhat && yarn install && yarn test`
- Foundry: `cd contracts-dev/foundry`, 의존성은 서브모듈이 아니라 `forge install foundry-rs/forge-std OpenZeppelin/openzeppelin-contracts Vectorized/solady` 로 받는다 (`lib/` 는 gitignore).
- Mantle 메인넷 RPC fork 로 실제 온체인 상태를 읽는 테스트/스크립트가 핵심 패턴.
