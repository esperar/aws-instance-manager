# AWS Instance Manager

AWS Instance Manager입니다.

AWS Instance들의 상태(실행, 중지, 종료)와 같은 여러가지 유틸 스크립트를 제공해줍니다.


## How to use

> Instance Manager를 사용하기 전, AWS CLI를 설치해야합니다.

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install awscli
$ aws --version
```

### Clone 

```bash
git clone https://github.com/esperar/aws-instance-manager.git
```

### Chmod, Execute Script

```bash
$ chmod -x <instance_scrpit>.sh
$ ./<instance_script>.sh
```


### 스케줄러 설정 (옵션)
이 스크립트를 자동으로 실행하려면 리눅스 크론 또는 윈도우 스케줄러와 같은 작업 스케줄러를 사용할 수 있습니다.

예를 들어, 새벽 2시에 스크립트를 실행하려면 리눅스 크론을 사용할 수 있습니다.

```bash
$ crontab -e
```

그리고 다음 라인을 추가하여 매일 새벽 2시에 스크립트를 실행하도록 설정합니다.

```bash
$ 0 2 * * * auto_stop_manager.sh
```



### 주의사항
이 스크립트들은 **사용자로부터 EC2 인스턴스 ID를 입력받습니다. 정확한 인스턴스 ID를 입력**하세요.
스크립트는 A**WS CLI를 사용하므로 인증이 필요합니다. AWS CLI 구성이 제대로 되어 있는지 확인하세요.**