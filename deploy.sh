docker build -t gaddiego/multi-client:latest -t gaddiego/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gaddiego/multi-server:latest -t gaddiego/multi-server_$SHA -f ./server/Dockerfile ./server
docker build -t gaddiego/multi-worker:latest -t gaddiego/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gaddiego/multi-client:latest
docker push gaddiego/multi-server:latest
docker push gaddiego/multi-worker:latest

docker push gaddiego/multi-client:$SHA
docker push gaddiego/multi-server:$SHA
docker push gaddiego/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=gaddiego/multi-client:$SHA
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=gaddiego/multi-worker:$SHA
