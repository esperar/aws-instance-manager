#!/bin/bash

# AWS CLI 설치 여부 확인
if ! command -v aws &> /dev/null
then
    echo "AWS CLI가 설치되어 있지 않습니다. 설치 후 다시 시도하세요."
    exit 1
fi

# 사용자로부터 인스턴스 ID 입력 받기
read -p "EC2 인스턴스 ID를 입력하세요: " instance_id

# 사용자로부터 시작 시간 입력 받기
read -p "인스턴스를 중지할 시작 시간을 입력하세요 (0-23): " start_hour

# 사용자로부터 종료 시간 입력 받기
read -p "인스턴스를 다시 시작할 종료 시간을 입력하세요 (0-23): " end_hour

# 현재 시간을 시간 단위로 가져오기
current_hour=$(date +"%H")

# 조건 확인: 입력받은 시작 시간 이상이고 종료 시간 미만이면 실행
if [ "$start_hour" -ge 0 ] && [ "$start_hour" -lt 24 ] && [ "$end_hour" -ge 0 ] && [ "$end_hour" -lt 24 ]
then
    # 첫 번째 입력받은 시간이 두 번째 입력받은 시간보다 낮은지 확인
    if [ "$start_hour" -lt "$end_hour" ]
    then
        # 입력 받은 시간 범위 내에서만 동작
        if [ "$current_hour" -ge "$start_hour" ] && [ "$current_hour" -lt "$end_hour" ]
        then
            # 인스턴스 상태 확인
            instance_status=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].State.Name' --output text)

            # 인스턴스 중지 또는 시작
            if [ "$instance_status" == "running" ]
            then
                echo "현재 시간은 $current_hour시로, 인스턴스를 중지합니다."
                aws ec2 stop-instances --instance-ids $instance_id
            else
                echo "현재 시간은 $current_hour시로, 인스턴스를 시작합니다."
                aws ec2 start-instances --instance-ids $instance_id
            fi
        else
            echo "현재 시간은 $current_hour시로, 인스턴스를 변경하지 않습니다."
        fi
    else
        echo "시작 시간은 종료 시간보다 높아야 합니다."
    fi
else
    echo "시간은 0부터 23까지의 숫자로 입력하세요."
fi
