#!bin/bash

# 기본 디렉터리
GITLAB_HOME=$HOME/docker/gitlab

# 경로가 존재하지 않을 경우 하위 폴더 생성
if [ ! -d $GITLAB_HOME ]; then
  sudo mkdir -p ~/docker/gitlab/{data,logs,config}
  echo "파일이 성공적으로 생성 되었습니다."

else
  # 존재할 경우 메시지 출력 후 스크립트 종료
  echo "파일이 존재합니다."  
fi


