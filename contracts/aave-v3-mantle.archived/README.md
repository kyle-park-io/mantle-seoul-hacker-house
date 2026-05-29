# Aave V3 — Mantle

Mantle 메인넷에 배포돼 운영 중인 **Aave V3 (`proto_mantle_v3` 마켓)** 핵심 컨트랙트의 레퍼런스·분석 모음입니다.

## 내용

| 파일 | 설명 |
| --- | --- |
| [`address.md`](./address.md) | 전체 배포 주소 (코어 + 자산 리저브). 출처: aave-address-book |
| `abi/` | 핵심 4종 ABI (Pool, PoolAddressesProvider, AaveProtocolDataProvider, AaveOracle) |
| `src/` | 핵심 4종 검증 소스 (Aave V3 origin) |
| [`analysis.md`](./analysis.md) | 분석 노트 |

## 출처 및 주의

- **주소**: [aave-address-book](https://github.com/bgd-labs/aave-address-book) `AaveV3Mantle.sol` (2026-05 기준)
- **ABI**: `@aave/core-v3` npm 패키지 artifacts에서 추출
- **소스**: [aave-v3-origin](https://github.com/aave/aave-v3-origin) `main` 브랜치

> ⚠️ ABI/소스는 Aave 공식 저장소·패키지에서 받은 것으로, 위 주소에 배포된 **바이트코드와 1:1로 검증한 것은 아닙니다** (탐색기 API 키 없이 진행). 정확한 온체인 일치 검증이 필요하면 Etherscan V2 API(chainid 5000)로 `getsourcecode`를 받아 대조하세요.
>
> `src/`의 `.sol`은 외부 import에 의존하는 단일 파일이라 그 자체로는 컴파일되지 않습니다. 읽기·분석용입니다.
