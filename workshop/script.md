# Aave 분석 데모 — 따라 하기

Mantle 에 배포된 Aave V3 를 가져와서, 실제 메인넷을 fork 떠서 USDC 상태를 읽어보는 실습입니다. 위에서부터 순서대로 따라 하세요.

에이전트한테는 폴더 위치나 코드 방식을 일일이 지정하지 않습니다. 의도만 말하면 [`CLAUDE.md`](../CLAUDE.md) 의 컨벤션을 읽고 알아서 처리합니다.

---

## 0. 사전 준비 — Foundry 설치

fork 테스트에는 Foundry(`forge`)가 필요합니다. 먼저 설치돼 있는지 확인하세요.

```bash
forge --version
```

버전이 안 뜨면 설치합니다 ([공식 문서](https://www.getfoundry.sh/introduction/installation)).

```bash
curl -L https://foundry.paradigm.xyz | bash   # foundryup 설치
foundryup                                       # forge/cast/anvil/chisel 설치
```

설치 후 터미널을 새로 열거나 `source ~/.bashrc` (zsh 는 `~/.zshrc`) 를 실행하세요.

> Hardhat 으로 따라올 거면 Foundry 대신 Node.js + yarn 만 있으면 됩니다.

---

## 1. Aave 가져오기

배포된 Aave 컨트랙트의 주소·ABI·소스를 `contracts/` 에 가져옵니다. 이미 `contracts/aave-v3-mantle/` 에 만들어져 있지만, 직접 재현하려면 아래 순서로 진행하세요.

**1-1.** 에이전트에 입력:

```
2026년 기준 Mantle에 배포된 Aave V3가 있는지, 핵심 컨트랙트 주소를 권위 있는 출처에서 확인해줘
```

→ `proto_mantle_v3` 마켓 확인, aave-address-book 에서 Pool / PoolAddressesProvider / DataProvider / Oracle 주소를 수집합니다.

**1-2.** 핵심 4종만 가져오라고 입력:

```
핵심 4종(Pool, PoolAddressesProvider, DataProvider, Oracle)만 contracts/ 에 가져와줘. 분석 용도야
```

→ `contracts/aave-v3-mantle/` 에 `address.md`(출처 명시), `abi/`(npm), `src/`(GitHub), 검증 한계를 적은 `README.md`, `analysis.md` 가 생깁니다.

**확인:** 폴더 위치를 지정하지 않았는데도 `contracts/aave-v3-mantle/` 에 정리됩니다. `CLAUDE.md` 의 "contracts/ 가져오기" 절차를 따른 결과입니다.

---

## 2. fork 테스트 만들기 (실습)

가져온 주소로 Mantle 을 fork 떠서 USDC 리저브 상태를 읽습니다. 정답지는 [`01-aave-read-only/`](./01-aave-read-only) 에 있으니, `contracts-dev/` 에 직접 만들어보고 나중에 대조하세요.

**2-1.** 테스트 생성 요청:

```
contracts/aave-v3-mantle 를 참고해서, Aave V3 USDC 리저브의 공급량·차입량·이자율을
Mantle fork 로 읽는 read-only 테스트를 만들어줘
```

→ `contracts-dev/foundry/src/aave/` 에 최소 인터페이스, `contracts-dev/foundry/test/aave/` 에 fork 테스트가 생깁니다. 위치·패턴은 `CLAUDE.md` 의 "프로토콜별로 묶는다" + "fork 테스트 작성 패턴" 을 따릅니다.

> 정확한 파일명이나 어떤 값을 assert 할지는 정해져 있지 않습니다 — 사람(또는 에이전트)마다 조금씩 다르게 나오는 게 정상입니다. `CLAUDE.md` 가 강제하는 건 **위치와 방식**(어디에 / 최소 인터페이스 / fork + 공개 RPC fallback / read-only)이지, 테스트 내용 한 글자까지가 아닙니다.

> Hardhat 으로 하려면 `contracts-dev/hardhat/test/aave/` 에 만들면 됩니다. 방식만 다르고(`network.create` + viem) 결과는 같습니다.

**2-2.** 의존성 설치 + 실행 요청:

```
의존성 설치하고 테스트 돌려봐
```

→ `forge install ...` 후 `forge test -vv`. 실제 메인넷 값이 출력됩니다 (시점마다 다름):

```
total supplied (aToken): ~15.5M USDC
total variable debt:     ~11.9M USDC
supply APR: ~2.3% · borrow APR: ~3.4%
USDC config: LTV 0 / collateral disabled / borrowing enabled
```

USDC 는 LTV 0, 담보 불가 — Mantle 에선 빌리는 자산으로만 쓰입니다.

**2-3.** 정답지와 대조:

```
workshop/01-aave-read-only 의 정답지와 내가 만든 걸 비교해줘
```

→ 파일이 똑같을 필요는 없습니다(인터페이스 모양·파일명·assert 는 다를 수 있음). 확인할 건 하나 — **같은 주소를 읽었으니 출력 수치가 일치**해야 합니다. 공급량·차입량 끝자리는 블록이 진행되며 조금씩 달라질 수 있지만 같은 리저브 값이면 정상입니다.

---

## 막힐 만한 곳

- **NatSpec `@return` 에러**: 주석에 반환값 이름을 안 맞추면 컴파일이 막힙니다. 일반 주석(`//`)으로 쓰세요.
- **Stack too deep**: `getReserveData` 는 반환값이 12개라 optimizer 가 꺼져 있으면 컴파일이 안 됩니다. `foundry.toml` 에 `optimizer = true` 를 넣으세요.

## 참고 — `CLAUDE.md` 변화

이 실습으로 `CLAUDE.md` 에 추가된 내용은 [`01-aave-read-only/claude-md.diff`](./01-aave-read-only/claude-md.diff) 에 있습니다 (workshop 폴더 정의, 프로토콜별 구조, fork 테스트 패턴).
