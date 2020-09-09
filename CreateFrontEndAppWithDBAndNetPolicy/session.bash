cloud_user@ip-10-0-1-101:~$ echo "create service and deployment to serve as a front end communicating with a database"
create service and deployment to serve as a front end communicating with a database
cloud_user@ip-10-0-1-101:~$ kubectl get nodes
NAME            STATUS   ROLES    AGE    VERSION
ip-10-0-1-101   Ready    master   102m   v1.13.3
ip-10-0-1-102   Ready    <none>   101m   v1.13.3
ip-10-0-1-103   Ready    <none>   101m   v1.13.3
cloud_user@ip-10-0-1-101:~$ kubectl create deployment webfront-deploy --image=nginx:1.7.8 --dry-run -o yaml > webfront-deploy.yaml
cloud_user@ip-10-0-1-101:~$ ls
webfront-deploy.yaml
cloud_user@ip-10-0-1-101:~$ vi webfront-deploy.yaml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$ kubectl apply -f webfront-deploy.yaml
deployment.apps/webfront-deploy created
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   0/1     1            0           10s
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   0/1     1            0           13s
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   0/1     1            0           17s
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   1/1     1            1           26s
cloud_user@ip-10-0-1-101:~$ kubectl scale deployment/webfront-deploy --replicas=2
deployment.extensions/webfront-deploy scaled
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   1/2     2            1           49s
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   1/2     2            1           54s
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   1/2     2            1           60s
cloud_user@ip-10-0-1-101:~$
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   1/2     2            1           66s
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   1/2     2            1           69s
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
webfront-deploy   2/2     2            2           88s
cloud_user@ip-10-0-1-101:~$ kubectl expose deployment/webfront-deploy --port=80 --target-port=80 --type=NodePort --dry-run -o yaml > webfront-service.yaml
cloud_user@ip-10-0-1-101:~$ vi webfront-service.yaml

cloud_user@ip-10-0-1-101:~$ kubectl apply -f webfront-service.yaml
service/webfront-service created
cloud_user@ip-10-0-1-101:~$ kubectl get services
NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP        108m
webfront-service   NodePort    10.100.186.136   <none>        80:30080/TCP   5s
cloud_user@ip-10-0-1-101:~$ kubectl run busybox --rm -it --image=busybox /bin/sh
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
If you don't see a command prompt, try pressing enter.
/ # wget --spider --timeout=1 webfront-service
Connecting to webfront-service (10.100.186.136:80)
remote file exists
/ # exit
Session ended, resume using 'kubectl attach busybox-96668698b-8xtl8 -c busybox -i -t' command when the pod is running
deployment.apps "busybox" deleted
cloud_user@ip-10-0-1-101:~$ kubectl get pods -o wide
NAME                               READY   STATUS    RESTARTS   AGE     IP           NODE            NOMINATED NODE   READINESS GATES
webfront-deploy-5d58fb8fc9-9thlc   1/1     Running   0          5m11s   10.244.1.2   ip-10-0-1-102   <none>           <none>
webfront-deploy-5d58fb8fc9-dvb4j   1/1     Running   0          4m27s   10.244.2.2   ip-10-0-1-103   <none>           <none>
cloud_user@ip-10-0-1-101:~$ kubectl run busybox --rm -it --image=busybox /bin/sh
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
If you don't see a command prompt, try pressing enter.
/ # wget -O- 10.244.1.2:80
Connecting to 10.244.1.2:80 (10.244.1.2:80)
writing to stdout
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
-                    100% |************************************************************************************************************************|   612  0:00:00 ETA
written to stdout
/ # exit
Session ended, resume using 'kubectl attach busybox-96668698b-ndhxt -c busybox -i -t' command when the pod is running
deployment.apps "busybox" deleted
cloud_user@ip-10-0-1-101:~$ kubectl run db-redis --image=redis --restart=Never
pod/db-redis created
cloud_user@ip-10-0-1-101:~$ kubectl get pods
NAME                               READY   STATUS              RESTARTS   AGE
db-redis                           0/1     ContainerCreating   0          4s
webfront-deploy-5d58fb8fc9-9thlc   1/1     Running             0          6m35s
webfront-deploy-5d58fb8fc9-dvb4j   1/1     Running             0          5m51s
cloud_user@ip-10-0-1-101:~$ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
db-redis                           1/1     Running   0          26s
webfront-deploy-5d58fb8fc9-9thlc   1/1     Running   0          6m57s
webfront-deploy-5d58fb8fc9-dvb4j   1/1     Running   0          6m13s
cloud_user@ip-10-0-1-101:~$ vi default-deny.yaml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$ kubectl apply -f default-deny.yaml
networkpolicy.networking.k8s.io/default-deny created
cloud_user@ip-10-0-1-101:~$ kubectl get networkpolicy
NAME           POD-SELECTOR   AGE
default-deny   <none>         10s
cloud_user@ip-10-0-1-101:~$ kubectl run busybox --rm -it --image=busybox /bin/sh
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
If you don't see a command prompt, try pressing enter.
/ # wget -O- 10.244.1.2:80
Connecting to 10.244.1.2:80 (10.244.1.2:80)
^C
/ # exit
Session ended, resume using 'kubectl attach busybox-96668698b-jjkjt -c busybox -i -t' command when the pod is running
deployment.apps "busybox" deleted
cloud_user@ip-10-0-1-101:~$ echo "the denial of connection there means the network policy we just made is working as intended"
the denial of connection there means the network policy we just made is working as intended
cloud_user@ip-10-0-1-101:~$ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
db-redis                           1/1     Running   0          5m22s
webfront-deploy-5d58fb8fc9-9thlc   1/1     Running   0          11m
webfront-deploy-5d58fb8fc9-dvb4j   1/1     Running   0          11m
cloud_user@ip-10-0-1-101:~$ kubectl label pod db-redis role=db
pod/db-redis labeled
cloud_user@ip-10-0-1-101:~$ kubectl label pod webfront-deploy-5d58fb8fc9-9thlc role=frontend
pod/webfront-deploy-5d58fb8fc9-9thlc labeled
cloud_user@ip-10-0-1-101:~$ kubectl label pod webfront-deploy-5d58fb8fc9-dvb4j role=frontend
pod/webfront-deploy-5d58fb8fc9-dvb4j labeled
cloud_user@ip-10-0-1-101:~$ kubectl get pods --show-labels
NAME                               READY   STATUS    RESTARTS   AGE     LABELS
db-redis                           1/1     Running   0          6m58s   role=db,run=db-redis
webfront-deploy-5d58fb8fc9-9thlc   1/1     Running   0          13m     app=webfront-deploy,pod-template-hash=5d58fb8fc9,role=frontend
webfront-deploy-5d58fb8fc9-dvb4j   1/1     Running   0          12m     app=webfront-deploy,pod-template-hash=5d58fb8fc9,role=frontend
cloud_user@ip-10-0-1-101:~$ echo "Now we can use the labels to add specificity to the network policy"
Now we can use the labels to add specificity to the network policy
cloud_user@ip-10-0-1-101:~$ vi redis-netpolicy.yaml
cloud_user@ip-10-0-1-101:~$ kubectl apply -f redis-netpolicy.yaml
error: error validating "redis-netpolicy.yaml": error validating data: ValidationError(NetworkPolicy.metadata): invalid type for io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta: got "string", expected "map"; if you choose to ignore these errors, turn validation off with --validate=false
cloud_user@ip-10-0-1-101:~$ vi redis-netpolicy.yaml
cloud_user@ip-10-0-1-101:~$ kubectl apply -f redis-netpolicy.yaml
networkpolicy.networking.k8s.io/redis-netpolicy created
cloud_user@ip-10-0-1-101:~$ kubectl get networkpolicies
NAME              POD-SELECTOR   AGE
default-deny      <none>         10m
redis-netpolicy   role=db        21s
cloud_user@ip-10-0-1-101:~$ kubectl get pods --show-labels
NAME                               READY   STATUS    RESTARTS   AGE   LABELS
db-redis                           1/1     Running   0          14m   role=db,run=db-redis
webfront-deploy-5d58fb8fc9-9thlc   1/1     Running   0          21m   app=webfront-deploy,pod-template-hash=5d58fb8fc9,role=frontend
webfront-deploy-5d58fb8fc9-dvb4j   1/1     Running   0          20m   app=webfront-deploy,pod-template-hash=5d58fb8fc9,role=frontend
