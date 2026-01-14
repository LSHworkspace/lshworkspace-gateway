## 도커 마스터클라이언트 룰
[예시](https://docs.docker.com/engine/swarm/manage-nodes/)
```bash
docker node update --lable-add manager lshworkspace-m00
```


## 네트워크 설정

과거의 내가 네트워크 자동설정 코드를 안작성 해뒀다, 미래의 나여 하거라
(https://watch-n-learn.tistory.com/49)
```bash
docker network create --attachable --driver overlay lshworkspace-proxy
```

## 도커로그인
서버에서 도커 로그인을 해줘 한다. 첫번쨰 설정할때
