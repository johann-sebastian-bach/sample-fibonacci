docker build -t oraserv/fib-frontend:latest -t oraserv/fib-frontend:$GIT_SHA -f ./frontend/Dockerfile ./frontend
docker build -t oraserv/fib-backend:latest -t oraserv/fib-backend:$GIT_SHA -f ./backend/Dockerfile ./backend
docker build -t oraserv/fib-worker:latest -t oraserv/fib-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push oraserv/fib-frontend:latest
docker push oraserv/fib-frontend:$GIT_SHA
docker push oraserv/fib-backend:latest
docker push oraserv/fib-backend:$GIT_SHA
docker push oraserv/fib-worker:latest
docker push oraserv/fib-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image fibo-frontend-deployment frontend=oraserv/fib-frontend:$GIT_SHA
kubectl set image fibo-backend-deployment backend=oraserv/fib-backend:$GIT_SHA
kubectl set image fibo-worker-deployment worker=oraserv/fib-worker:$GIT_SHA
