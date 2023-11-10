# AWS Instance Manager

AWS Instance Manager입니다.

AWS Instance들의 상태(실행, 중지, 종료)와 같은 여러가지 유틸 스크립트를 제공해줍니다.

## How to use

### Clone 

```bash
git clone https://github.com/esperar/aws-instance-manager.git
```

### Chmod, Execute Script

```bash
chmod -x <instance_scrpit>.sh
./<instance_script>.sh
```

### Cron

```bash
0 * * * * <instance_script>.sh
```
