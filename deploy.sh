docker build -t chasereed7/multi-client:latest -t chasereed7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chasereed7/multi-server:latest -t chasereed7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chasereed7/mulit-worker:latest -t chasereed7/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chasereed7/multi-client:latest
docker push chasereed7/multi-server:latest
docker push chasereed7/multi-worker:latest
docker push chasereed7/multi-client:$SHA
docker push chasereed7/multi-server:$SHA
docker push chasereed7/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chasereed7/multi-server:$SHA
kubectl set image deployments/client-deployment client=chasereed7/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chasereed7/multi-worker:$SHA