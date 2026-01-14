if ! docker info | grep -q 'Swarm: active'; then
  docker swarm init
fi

if ! docker network ls | grep -q 'lshworkspace-proxy'; then
  docker network create --driver overlay --attachable lshworkspace-proxy
fi
