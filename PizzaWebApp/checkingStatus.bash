cloud_user@ip-10-0-1-101:~$ ls
pizza-deployment.yml  pizza-service.yml
cloud_user@ip-10-0-1-101:~$ cat pizza-deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pizza-deployment
  namespace: pizza
spec:
  replicas: 3
  selector:
    matchLabels:
      app: pizza
  template:
    metadata:
      labels:
        app: pizza
    spec:
      containers:
      - name: pizza
        image: linuxacademycontent/pizza-service:1.14.6
        command: ["nginx"]
        args: ["-g", "daemon off;"]
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8081
        readinessProbe:
          httpGet:
            path: /
            port: 80

cloud_user@ip-10-0-1-101:~$ cat pizza-service.yml
apiVersion: v1
kind: Service
metadata:
  name: pizza-service
  namespace: pizza
spec:
  type: NodePort
  selector:
    app: pizza
  ports:
  - protocol: TCP
    port: 80
    nodePort: 30080
cloud_user@ip-10-0-1-101:~$ kubectl get deploy -n pizza
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
pizza-deployment   3/3     3            3           10m
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n pizza
NAME                                READY   STATUS    RESTARTS   AGE
pizza-deployment-84cb4894c7-fnwlf   1/1     Running   0          10m
pizza-deployment-84cb4894c7-jshww   1/1     Running   0          10m
pizza-deployment-84cb4894c7-xp2vl   1/1     Running   0          10m
cloud_user@ip-10-0-1-101:~$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   150m
cloud_user@ip-10-0-1-101:~$ kubectl get svc -n pizza
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
pizza-service   NodePort   10.111.163.61   <none>        80:30080/TCP   7m11s
cloud_user@ip-10-0-1-101:~$ kubectl get ep pizza-service -n pizza
NAME            ENDPOINTS                                   AGE
pizza-service   10.244.1.4:80,10.244.2.3:80,10.244.2.4:80   7m31s
cloud_user@ip-10-0-1-101:~$ curl localhost:30080
{
  "description": "A list of pizza toppings.",
  "pizzaToppings": [
    "anchovies",
    "artichoke",
    "bacon",
    "breakfast bacon",
    "Canadian bacon",
    "cheese",
    "chicken",
    "chili peppers",
    "feta",
    "garlic",
    "green peppers",
    "grilled onions",
    "ground beef",
    "ham",
    "hot sauce",
    "meatballs",
    "mushrooms",
    "olives",
    "onions",
    "pepperoni",
    "pineapple",
    "sausage",
    "spinach",
    "sun-dried tomato",
    "tomatoes"
  ]
}
