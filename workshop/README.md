# workshop

Mantle 위에서 **배포된 컨트랙트를 분석·테스트하는 흐름**을, 그리고 그 과정에서 **`CLAUDE.md`(에이전트 컨벤션)가 어떻게 자라는지**를 단계별로 보여주는 데모.

## 이 데모가 보여주는 두 가지

1. **기술**: `contracts/` 의 프로덕션 레퍼런스(Aave V3 등)를 보고 → `contracts-dev/` 에서 fork 테스트로 실제 동작을 검증한다.
2. **메타**: 작업을 하나 끝낼 때마다 `CLAUDE.md` 에 무엇이·왜 추가되는지. 그 컨벤션이 쌓이면, 다음에 같은 작업을 시키는 사람(또는 에이전트)이 **별 설명 없이도 올바른 위치에 올바른 방식으로** 코드를 만들게 된다.

## 두 가지 모드

| | 완성본 (정답지) | 실습 |
| --- | --- | --- |
| 어디에 | `workshop/<step>/` | `contracts-dev/` |
| 무엇 | 발표자가 미리 만든, 그대로 도는 데모 | 참가자가 직접 채워가는 빈 자리 |
| 핵심 | "이렇게 되면 된다" 를 한 폴더로 | `CLAUDE.md` 컨벤션을 따라 에이전트가 알아서 올바른 위치에 생성 |

> 실습 시연: 참가자가 "Aave USDC 리저브를 fork 로 읽는 테스트 만들어줘" 라고 하면, 에이전트는 `CLAUDE.md` 의 "fork 테스트 작성 패턴" 을 읽고 `contracts-dev/foundry/{src,test}/aave/` 에 코드를 만든다. 정답지(`workshop/01-...`)와 대조하며 확인.

### 스택 선택 (Foundry / Hardhat)

`contracts-dev/` 는 **Foundry 와 Hardhat 두 스택**을 같은 컨트랙트에 대해 보여주는 게 컨셉이다. workshop 정답지는 간결함을 위해 **Foundry 로만** 제공하지만, 실습에서는 둘 중 어느 쪽으로 만들어도 된다.

- **Foundry**: `contracts-dev/foundry/test/aave/AaveReadOnly.t.sol` — 최소 인터페이스 + `vm.createSelectFork`
- **Hardhat**: `contracts-dev/hardhat/test/aave/*.test.ts` — `network.create({ network: "mantleFork" })` + viem `readContract` 로 인라인 ABI 직접 호출 (기존 `mantle.usdc.test.ts` 패턴)

두 스택 모두 같은 배포 주소(`contracts/aave-v3-mantle/address.md`)를 읽으므로 결과가 일치해야 한다 — 그 자체가 데모 포인트.

## 진행 방법

발표자가 청중 앞에서 읽으며 진행하는 **구어체 발표 대본**이 [`script.md`](./script.md) 에 있다. 말하는 멘트와 실제로 입력/시연하는 명령을 구분해서, Aave 를 가져온 0단계부터 fork 테스트 1단계까지 순서대로 따라간다.

## 단계

| 단계 | 내용 | 정답지 |
| --- | --- | --- |
| 0 | 배포된 Aave V3 핵심 컨트랙트를 `contracts/` 로 가져오기 | [`../contracts/aave-v3-mantle/`](../contracts/aave-v3-mantle) |
| 01 | Aave V3 USDC 리저브 read-only 조회 (fork) | [`01-aave-read-only/`](./01-aave-read-only) |

> 다음 단계(supply, borrow 등)는 데모를 진행하며 추가한다.
