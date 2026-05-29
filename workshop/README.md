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

### 스택 — 이 워크숍은 Foundry 로 진행

`contracts-dev/` 자체는 Foundry 와 Hardhat 두 스택을 지원하지만(`CLAUDE.md` 의 "fork 테스트 작성 패턴" 에 둘 다 정리돼 있다), **이 워크숍은 Foundry 한 스택으로만 진행한다.** 정답지도 Foundry 로만 있으니 대조도 Foundry 끼리 한다.

- **Foundry**: `contracts-dev/foundry/test/aave/` — 최소 인터페이스(`src/aave/`) + `vm.createSelectFork` 로 Mantle fork → read-only assert.

0단계에서 받아온 배포 주소(`contracts/aave-v3-mantle/address.md`)를 읽으므로, 누가 만들어도 출력 수치가 일치해야 한다 — 그게 대조 포인트.

## 진행 방법

참가자가 보고 그대로 따라 하는 **실습 가이드**가 [`script.md`](./script.md) 에 있다. 위에서부터 순서대로, Aave 를 가져오는 0단계부터 fork 테스트 1단계까지 따라간다.

## 단계

| 단계 | 내용 | 정답지 |
| --- | --- | --- |
| 0 | 배포된 Aave V3 핵심 컨트랙트를 `contracts/` 로 가져오기 (실습으로 직접 받아옴) | 정답지: [`../contracts/aave-v3-mantle.archived/`](../contracts/aave-v3-mantle.archived) |
| 01 | Aave V3 USDC 리저브 read-only 조회 (fork) | [`01-aave-read-only/`](./01-aave-read-only) |

> 다음 단계(supply, borrow 등)는 데모를 진행하며 추가한다.
