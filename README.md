# mantle-seoul-hacker-house

Mantle 체인 위에서 컨트랙트를 **개발하고, 배포된 컨트랙트를 분석하고, 데모로 실습**하는 모노레포입니다.

## 폴더 구조

| 폴더                                | 설명                                                                                       |
| ----------------------------------- | ------------------------------------------------------------------------------------------ |
| [`contracts/`](./contracts)         | 이미 온체인에 배포돼 운영 중인 **프로덕션 컨트랙트의 레퍼런스·분석** 모음 (주소/ABI/소스). |
| [`contracts-dev/`](./contracts-dev) | 우리가 직접 작성·실험하는 **개발 워크스페이스** (Hardhat 3 + Foundry).                     |
| [`workshop/`](./workshop)           | 단계별 **데모/실습** — 배포된 Aave 를 가져와 fork 로 분석하는 과정을 따라 한다.            |
| [`external/`](./external)           | 외부 레포 git **서브모듈**.                                                                |

## 시작하기

- 작업 컨벤션과 절차(폴더 용도, 컨트랙트 가져오기, fork 테스트 패턴 등)는 [`CLAUDE.md`](./CLAUDE.md) 에 정리돼 있습니다.
- 데모를 따라 하려면 [`workshop/script.md`](./workshop/script.md) 를 보세요.
- 서브모듈 포함 클론: `git clone --recurse-submodules <repo>` (또는 클론 후 `git submodule update --init --recursive`).
