cloud_user@ip-10-0-1-101:~$ kubectl run nginx --image=nginx
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/nginx created
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   0/1     1            0           9s
cloud_user@ip-10-0-1-101:~$ kubectl get deployments
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   1/1     1            1           16s
cloud_user@ip-10-0-1-101:~$ kubectl expose deployment nginx --port 80 --type NodePort
service/nginx exposed
cloud_user@ip-10-0-1-101:~$ kubectl get services
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP        13m
nginx        NodePort    10.102.155.212   <none>        80:30521/TCP   9s
cloud_user@ip-10-0-1-101:~$ vi busybox.yml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$ kubectl create -f busybox.yml
The Pod "busybox" is invalid: spec.restartPolicy: Unsupported value: "always": supported values: "Always", "OnFailure", "Never"
cloud_user@ip-10-0-1-101:~$ vi busybox.yml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$ kubectl create -f busybox.yml
pod/busybox created
cloud_user@ip-10-0-1-101:~$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
busybox                  1/1     Running   0          6s
nginx-7cdbd8cdc9-qt8cx   1/1     Running   0          3m36s
cloud_user@ip-10-0-1-101:~$ kubectl exec busybox -- nslookup nginx
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx
Address 1: 10.102.155.212 nginx.default.svc.cluster.local
