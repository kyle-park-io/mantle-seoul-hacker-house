# contracts

실제 온체인에 배포돼 운영 중인 **프로덕션 컨트랙트의 레퍼런스 모음집**입니다. 배포된 컨트랙트의 소스 / 주소 / ABI를 끌어와 보관하고, 이를 바탕으로 분석합니다.

> 우리가 직접 개발·실험하는 코드는 [`../contracts-dev`](../contracts-dev) 에 있습니다. 이 폴더는 그것과 별개로, **이미 배포되어 돌아가는 컨트랙트를 참조·분석**하기 위한 곳입니다.

## 수집된 컨트랙트

| 프로토콜 | 네트워크 | 내용 |
| --- | --- | --- |
| [`aave-v3-mantle/`](./aave-v3-mantle) | Mantle 메인넷 | Aave V3 (`proto_mantle_v3`) 핵심 4종 — Pool, PoolAddressesProvider, AaveProtocolDataProvider, AaveOracle |

## 폴더 구조

각 프로토콜은 `contracts/<protocol>/` 아래에 다음 형태로 정리합니다 (`aave-v3-mantle/` 가 참고 사례):

```
contracts/
└── <protocol>/
    ├── README.md     ← 출처·주의사항
    ├── address.md    ← 네트워크별 배포 주소
    ├── abi/          ← 컨트랙트별 ABI (*.json)
    ├── src/          ← 배포된 컨트랙트 소스 (읽기·분석용)
    └── analysis.md   ← 분석 노트 (구조, 호출 흐름, 리스크 등)
```

> 가져오는 표준 절차는 루트 [`CLAUDE.md`](../CLAUDE.md) 의 "contracts/ — 프로덕션 컨트랙트 가져오기" 참고.
