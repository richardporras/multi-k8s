docker build -t ricopopo92/multi-client:latest  -t ricopopo92/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ricopopo92/multi-server:latest -t ricopopo92/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ricopopo92/multi-worker:latest -t ricopopo92/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ricopopo92/multi-client:latest
docker push ricopopo92/multi-server:latest
docker push ricopopo92/multi-worker:latest

docker push ricopopo92/multi-client:$SHA
docker push ricopopo92/multi-server:$SHA
docker push ricopopo92/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ricopopo92/multi-server:$SHA
kubectl set image deployments/client-deployment server=ricopopo92/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ricopopo92/worker-client:$SHA
