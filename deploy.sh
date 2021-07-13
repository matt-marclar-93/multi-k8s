docker build -t cincobot/multi-client-k8s:latest -t cincobot/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t cincobot/multi-server-k8s-pgfix:latest -t cincobot/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t cincobot/multi-worker-k8s:latest -t cincobot/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push cincobot/multi-client-k8s:latest
docker push cincobot/multi-server-k8s-pgfix:latest
docker push cincobot/multi-worker-k8s:latest

docker push cincobot/multi-client-k8s:$SHA
docker push cincobot/multi-server-k8s-pgfix:$SHA
docker push cincobot/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cincobot/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=cincobot/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=cincobot/multi-worker-k8s:$SHA