#!/bin/bash

# AWS CLI 설치 여부 확인
if ! command -v aws &> /dev/null
then
    echo "AWS CLI가 설치되어 있지 않습니다. 설치 후 다시 시도하세요."
    exit 1
fi

# 사용자로부터 인스턴스 ID 입력 받기
read -p "EC2 인스턴스 ID를 입력하세요: " instance_id

# AWS CLI를 사용하여 EC2 인스턴스의 현재 상태 확인
instance_status=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].State.Name' --output text)

# 새벽에만 인스턴스 중지 및 시작 (예: 02:00부터 07:00까지)
current_hour=$(date +"%H")

if [ "$current_hour" -ge 2 ] && [ "$current_hour" -lt 7 ]
then
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
