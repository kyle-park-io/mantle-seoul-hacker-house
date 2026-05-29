# 01 · Aave V3 USDC 리저브 read-only 조회

## 목표

Mantle 메인넷에 배포된 **Aave V3** 의 USDC 리저브 상태(공급량·차입량·이자율·설정)를 fork 테스트로 읽는다. 상태 변경 없음, 순수 조회.

## 진행 흐름

### 1) 레퍼런스 확보 (`contracts/`)
배포된 Aave 컨트랙트의 주소·ABI·소스를 `contracts/aave-v3-mantle/` 에 먼저 가져왔다 (실습에서는 0단계로 직접 받아오며, 정답지는 `contracts/aave-v3-mantle.archived/` 에 보관). 주소는 권위 있는 [aave-address-book](https://github.com/aave-dao/aave-address-book) 에서. 이 단계에서 쓰는 컨트랙트:

- **AaveProtocolDataProvider** `0x487c5c669D9eee6057C44973207101276cf73b68` — 리저브 상태 집계 뷰
- USDC underlying `0x09Bc4E0D864854c6aFB6eB9A9cdF58aC190D0dF9`

### 2) 최소 인터페이스 (`src/`)
전체 Aave 소스를 끌어올 필요 없이, 이 데모가 쓰는 두 뷰함수만 담은 인터페이스를 직접 선언했다 — [`IAaveProtocolDataProvider.sol`](./foundry/src/IAaveProtocolDataProvider.sol). 시그니처는 `contracts/aave-v3-mantle/abi/` 의 ABI 에서 확인.

### 3) fork 테스트 (`test/`)
[`AaveReadOnly.t.sol`](./foundry/test/AaveReadOnly.t.sol) — 공개 RPC fallback 으로 Mantle 을 fork 하고, USDC 리저브의 `getReserveData` / `getReserveConfigurationData` 를 읽어 로그 + assert.

```
forge test -vv
```

> 이 워크숍은 **Foundry 로만** 진행한다 — 정답지도 Foundry 라 대조가 쉽다. (`contracts-dev/` 자체는 Hardhat 도 지원하고 두 스택 패턴이 `CLAUDE.md` 의 "fork 테스트 작성 패턴" 에 정리돼 있지만, 워크숍 실습 범위 밖이다.)

### 4) 실제 결과 (라이브)
```
=== Aave V3 USDC reserve (Mantle) ===
total supplied (aToken, 6dp): 15532509989478   (~15.5M USDC)
total variable debt   (6dp): 11896534530249    (~11.9M USDC)
supply APR (bp): 234   (2.34%)
borrow APR (bp): 340   (3.40%)

=== Aave V3 USDC config (Mantle) ===
decimals: 6 · reserve factor: 10% · borrowing enabled: true
LTV: 0 · collateral enabled: false   ← USDC는 Mantle에서 담보로는 안 쓰이고 차입 자산으로만
```

## 막혔던 지점 (데모에서 짚을 것)

- **NatSpec `@return`**: 반환 파라미터에 이름이 있으면 `@return <name>` 형식이 강제됨. 묶어서 적으면 컴파일 실패 → 일반 주석으로.
- **Stack too deep**: `getReserveData` 가 12개를 반환해서 optimizer 없이는 컴파일 실패 → `optimizer = true`.

## 이 단계가 `CLAUDE.md` 에 남긴 것

이번 작업으로 루트 `CLAUDE.md` 에 다음이 추가됐다 (`claude-md.diff` 참고):

1. **`workshop/` 폴더**의 존재와 목적 (완성본 vs 실습 모드).
2. **`contracts-dev/` 소스를 프로토콜별로 묶는다**는 구조 컨벤션 — `contracts/` 분석 대상과 1:1 대응.
3. **fork 테스트 작성 패턴** — 레퍼런스에서 주소·ABI 확보 → 최소 인터페이스 → 공개 RPC fallback fork → read-only assert → optimizer 주의.

→ 이게 핵심: 다음에 누군가 "Aave borrow 도 테스트해줘" 라고 하면, 에이전트는 이 컨벤션을 읽고 **설명 없이** `contracts-dev/foundry/test/aave/` 에 같은 패턴으로 코드를 만든다.
