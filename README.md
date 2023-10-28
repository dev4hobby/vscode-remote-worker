# VSCode remote worker w/ Docker

M1 맥북에서 debian, fedora 계열의 빌드 및 디버깅을 진행하기위해 docker를 이용하여 환경을 구성했습니다

`docker-compose.yaml` 파일을 이용하여 `code-server`와 `ssh-remote-server` 컨테이너를 실행합니다.

- gdb를 이용한 디버깅을 위해 `--cap-add=SYS_PTRACE` 옵션을 추가하였습니다.
- system call 사용을 위해 `--security-opt seccomp=unconfined` 옵션을 추가하였습니다.

## Structure

```bash
❯ tree .
.
├── Makefile
├── README.md
├── build.sh
├── code-server.Dockerfile
├── docker-compose.yaml
├── ssh-remote-server.Dockerfile
└── workspace
    ├── Makefile
    └── hello.c
```

- `code-server.Dockerfile`: 웹 환경의 VSCode 서비스를 실행하기위한 이미지
- `ssh-remote-server.Dockerfile`: ssh 서버를 실행하기위한 이미지
- `workspace`: 로컬환경에서 작성한 코드를 각 컨테이너에서 사용하기위해 mount한 디렉토리

## Usage

```bash
❯ make help

Usage:
  make <target>

Targets:
  help                  지금 보고계신 도움말
  up                    컨테이너를 실행합니다.
  down                  컨테이너를 종료합니다.
  build                 컨테이너를 빌드합니다.
  logs                  컨테이너 로그를 보여줍니다.
  ps                    컨테이너 상태를 보여줍니다.
```

### 컨테이너 실행

```bash
make build
make up
```

이미지 빌드 후 컨테이너를 실행합니다.

### 웹 연결

컨테이너 실행 후, [localhost:8080](http://localhost:8000)으로 접속하면 VSCode가 실행됩니다.

### ssh 연결

터미널을 사용하는경우  `ssh -p 22 code@localhost` 명령어를 통해 ssh 접속이 가능합니다.

### vscode remote 연결

[Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) 익스텐션을 설치하고, `F1` 키를 눌러 `Remote-SSH: Connect to Host...` 명령어를 입력합니다.

`ssh -p 22 code@localhost` 명령어를 입력하면, `~/.ssh/config` 파일에 아래와 같이 추가됩니다.

```bash
Host localhost
    HostName localhost
    User code
    Port 22
```

`localhost`를 선택하면, `code-server` 컨테이너에 접속할 수 있습니다.
