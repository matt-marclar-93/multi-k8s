docker build -t cygnetops/multi-client:latest -t cygnetops/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cygnetops/multi-server:latest -t cygnetops/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cygnetops/multi-worker:latest -t cygnetops/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push cygnetops/multi-client:latest
docker push cygnetops/multi-server:latest
docker push cygnetops/multi-worker:latest

docker push cygnetops/multi-client:$SHA
docker push cygnetops/multi-server:$SHA
docker push cygnetops/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cygnetops/multi-server:$SHA
kubectl set image deployments/client-deployment client=cygnetops/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cygnetops/multi-worker:$SHA