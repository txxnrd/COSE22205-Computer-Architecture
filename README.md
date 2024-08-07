# COSE222(05)-컴퓨터구조

이 리포지토리는 이중희 교수님 컴퓨터 구조 최종 과제로 MIPS SystemVerilog를 사용하여 기본 CPU 아키텍처를 구현한 것입니다.
이 프로젝트는 여러 주요 구성 요소를 갖춘 CPU의 설계와 시뮬레이션을 보여줍니다. 각 구성 요소에 대한 자세한 설명은 아래와 같습니다.

## 구성 요소

### 산술 논리 장치 (ALU)

ALU는 산술 및 논리 연산을 수행하는 역할을 합니다. 레지스터에서 피연산자를 받아 덧셈, 뺄셈, AND, OR, XOR 등의 연산을 제어 신호에 따라 수행합니다.

### 명령어 메모리 (imem1.sv)

명령어 메모리는 CPU가 실행하는 명령어를 저장합니다. 읽기 전용 메모리로 프로그램 명령어로 초기화됩니다. CPU는 명령어 사이클의 페치 단계에서 이 메모리에서 명령어를 가져옵니다.

### 데이터 메모리 (dmem1.sv)

데이터 메모리는 프로그램이 조작하는 데이터를 저장하는 데 사용됩니다. 읽기 및 쓰기 작업을 지원합니다. CPU는 로드/스토어 작업 중 이 메모리에 접근합니다.

### 컨트롤러

컨트롤러는 현재 명령어를 기반으로 제어 신호를 생성하여 CPU의 작동을 관리합니다. 명령어 사이클의 페치, 디코드, 실행, 메모리 액세스, 쓰기-백 단계를 조정합니다.

### 레지스터 파일

레지스터 파일은 임시 데이터와 피연산자를 저장하는 레지스터 세트로 구성됩니다. 레지스터에 대한 읽기 및 쓰기 접근을 제공합니다. CPU는 중간 값과 연산 결과를 저장하기 위해 이 레지스터를 사용합니다.

## 구현 세부 사항

- **언어:** SystemVerilog
- **CPU 구조:** CPU는 명령어를 효율적으로 실행하기 위해 여러 단계의 파이프라인으로 설계되었습니다.
