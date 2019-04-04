docker build -t hoacaphe/multi-client:latest -t hoacaphe/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hoacaphe/multi-server:latest -t hoacaphe/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hoacaphe/multi-worker:latest -t hoacaphe/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hoacaphe/multi-client:latest
docker push hoacaphe/multi-client:$SHA

docker push hoacaphe/multi-server:latest
docker push hoacaphe/multi-server:$SHA

docker push hoacaphe/multi-worker:latest
docker push hoacaphe/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=hoacaphe/multi-client:$SHA
kubectl set image deployments/server-deployment server=hoacaphe/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hoacaphe/multi-worker:$SHA
