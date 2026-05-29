# Aave V3 (Mantle) 분석 노트

## 개요

- 마켓: `proto_mantle_v3`, 체인: Mantle (5000)
- Solidity: `^0.8.10`
- 라이선스: 코어 컨트랙트(Pool 등)는 `BUSL-1.1`, 헬퍼(DataProvider/Oracle)는 `MIT`

## 컨트랙트 역할

| 컨트랙트 | 역할 |
| --- | --- |
| **Pool** | 사용자 진입점. 공급/대출/상환/인출/청산/플래시론. `PoolAddressesProvider`로 주소 확인. |
| **PoolAddressesProvider** | 마켓 단위 레지스트리. Pool, PoolConfigurator, ACLManager, PriceOracle 등의 주소를 보관·갱신. 진위 확인의 루트. |
| **AaveProtocolDataProvider** | 읽기 전용 집계 뷰. 리저브 목록, 설정, 이자율, 유저 포지션 등을 한 번에 조회. 온체인 분석의 주 진입점. |
| **AaveOracle** | 자산별 가격 피드 소스. 청산·LTV 계산의 기준 가격 제공. |

## Pool 핵심 외부 함수 (src/Pool.sol)

| 함수 | 위치 | 비고 |
| --- | --- | --- |
| `supply` | L119 | 담보/예치 |
| `withdraw` | L178 | 인출 |
| `borrow` | L202 | 차입 |
| `repay` | L231 | 상환 |
| `setUserUseReserveAsCollateral` | L315 | 담보 토글 |
| `liquidationCall` | L333 | 청산 |
| `flashLoan` | L361 | 플래시론 |
| `getReserveData` | L425 | 리저브 상태 조회 |
| `getUserAccountData` | L456 | 유저 헬스/담보/부채 조회 |

## 분석 시작점 (제안)

1. **온체인 상태 읽기** — `contracts-dev`의 Foundry/Hardhat fork에서 `AaveProtocolDataProvider`로 각 리저브의 공급/차입/이자율 스냅샷.
2. **주소 진위 검증** — `PoolAddressesProvider.getPool()` 등이 `address.md`의 주소와 일치하는지 fork에서 확인.
3. **가격·청산 경로** — `AaveOracle`에서 자산 가격 조회 → `getUserAccountData`의 health factor 계산 흐름 추적.

## TODO

- [ ] fork 기반 read-only 스냅샷 스크립트 (`contracts-dev`)
- [ ] aToken/variableDebtToken ABI·소스 추가 여부 결정
- [ ] (선택) Etherscan V2 API로 온체인 바이트코드 ↔ 소스 일치 검증
