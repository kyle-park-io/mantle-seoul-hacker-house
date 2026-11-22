# mantle-seoul-hacker-house

Mantle 체인 위에서 컨트랙트를 **개발하고, 배포된 컨트랙트를 분석하고, 데모로 실습**하는 모노레포입니다.

## 구조

폴더마다 든 것을 아래 표에 적었습니다. 경로는 레포 맨 위 폴더에서 셉니다.

| 경로 | 설명 |
|---|---|
| [`contracts/`](contracts/) | 배포돼 운영 중인 프로덕션 컨트랙트의 레퍼런스. 분석할 프로토콜을 찾을 때 연다 |
| &nbsp;&nbsp;&nbsp;&nbsp;[`aave-v3-mantle.archived/`](contracts/aave-v3-mantle.archived/) | 워크샵 0단계의 정답지. Aave V3 핵심 컨트랙트 4종의 주소, ABI, 소스, 분석 노트 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`abi/`](contracts/aave-v3-mantle.archived/abi/) | Pool, PoolAddressesProvider, AaveProtocolDataProvider, AaveOracle의 ABI(JSON) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`src/`](contracts/aave-v3-mantle.archived/src/) | 같은 4종의 Solidity 소스. 읽고 분석하는 용도 |
| [`contracts-dev/`](contracts-dev/) | 직접 작성하고 시험하는 개발 워크스페이스. Hardhat 3과 Foundry 두 스택 |
| &nbsp;&nbsp;&nbsp;&nbsp;[`docs/`](contracts-dev/docs/) | 2026년 기준 Solidity 개발 환경 세팅 가이드 |
| &nbsp;&nbsp;&nbsp;&nbsp;[`foundry/`](contracts-dev/foundry/) | Foundry 스택. foundry.toml에 기본, via_ir, stack_deep 프로파일 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`demos/`](contracts-dev/foundry/demos/) | 기본 빌드에 들어가지 않는 데모 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`stack_too_deep/`](contracts-dev/foundry/demos/stack_too_deep/) | stack too deep 오류와 via_ir 설정으로 해결되는 과정을 보이는 컨트랙트 하나 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`script/`](contracts-dev/foundry/script/) | forge script. 테스트넷 배포(Deploy.s.sol)와 포크 위 볼륨 시뮬레이션(VolumeSim.s.sol) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`src/`](contracts-dev/foundry/src/) | 컨트랙트와 인터페이스. 프로토콜 이름 폴더(chainlink, merchant-moe)와 범용 shared로 나눈다 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`test/`](contracts-dev/foundry/test/) | 포크 시험과 가스 비교. src와 같은 프로토콜 이름으로 나눈다 |
| &nbsp;&nbsp;&nbsp;&nbsp;[`hardhat/`](contracts-dev/hardhat/) | Hardhat 3 스택(viem, Ignition). 환경 변수 이름은 .env.example에 있다 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`contracts/`](contracts-dev/hardhat/contracts/) | Foundry의 src와 같은 컨트랙트 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`ignition/`](contracts-dev/hardhat/ignition/) | Ignition 배포 정의 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`modules/`](contracts-dev/hardhat/ignition/modules/) | MantleUSDCDeploy.ts. 모의 USDC 배포 모듈 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`scripts/`](contracts-dev/hardhat/scripts/) | deploy.ts와 volumeSim.ts. Foundry 스크립트를 옮긴 것 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`test/`](contracts-dev/hardhat/test/) | 포크 시험(USDC, Chainlink, 체인 정보, Merchant Moe 볼륨) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`types/`](contracts-dev/hardhat/types/) | eth-chainlist 모듈의 타입 선언 |
| [`external/`](external/) | 외부 레포 git 서브모듈. 목록은 .gitmodules |
| &nbsp;&nbsp;&nbsp;&nbsp;[`byreal-skill-for-fun/`](external/byreal-skill-for-fun/) | 서브모듈. kyle-park-io/byreal-skill-for-fun |
| &nbsp;&nbsp;&nbsp;&nbsp;[`byreal-agent-skills/`](external/byreal-agent-skills/) | 서브모듈. kyle-park-io/byreal-agent-skills |
| &nbsp;&nbsp;&nbsp;&nbsp;[`RealClaw-Skills/`](external/RealClaw-Skills/) | 서브모듈. kyle-park-io/RealClaw-Skills |
| &nbsp;&nbsp;&nbsp;&nbsp;[`mantle-agent-cli/`](external/mantle-agent-cli/) | 서브모듈. kyle-park-io/mantle-agent-cli |
| &nbsp;&nbsp;&nbsp;&nbsp;[`mantle-skills/`](external/mantle-skills/) | 서브모듈. kyle-park-io/mantle-skills |
| &nbsp;&nbsp;&nbsp;&nbsp;[`mantle-agent-scaffold/`](external/mantle-agent-scaffold/) | 서브모듈. kyle-park-io/mantle-agent-scaffold |
| &nbsp;&nbsp;&nbsp;&nbsp;[`chains/`](external/chains/) | 서브모듈. kyle-park-io/chains |
| [`workshop/`](workshop/) | 단계별 데모와 실습 가이드. 배포된 Aave를 가져와 fork로 분석하는 과정을 따라 한다. 따라 하는 순서는 script.md |
| &nbsp;&nbsp;&nbsp;&nbsp;[`01-aave-read-only/`](workshop/01-aave-read-only/) | 1단계 완성본. Aave V3 USDC 리저브를 포크 위에서 읽는 테스트 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`foundry/`](workshop/01-aave-read-only/foundry/) | 이 단계만 단독으로 도는 Foundry 프로젝트(src, test) |
| [`.gitmodules`](.gitmodules) | external/ 서브모듈의 경로와 주소 |
| [`CLAUDE.md`](CLAUDE.md) | 에이전트용 작업 컨벤션. 폴더 용도, 컨트랙트 가져오기, 포크 시험 패턴 |

## 시작하기

- 작업 컨벤션과 절차(폴더 용도, 컨트랙트 가져오기, fork 테스트 패턴 등)는 [`CLAUDE.md`](./CLAUDE.md) 에 정리돼 있습니다.
- 데모를 따라 하려면 [`workshop/script.md`](./workshop/script.md) 를 보세요.
- 서브모듈 포함 클론: `git clone --recurse-submodules <repo>` (또는 클론 후 `git submodule update --init --recursive`).
