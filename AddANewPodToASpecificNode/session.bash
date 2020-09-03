.
.
.
// The directive here was to make a pod and deploy it on a node where disk=ssd.
.
.
.
cloud_user@ip-10-0-1-101:~$ kubectl get nodes --show-labels
NAME            STATUS   ROLES    AGE   VERSION   LABELS
ip-10-0-1-101   Ready    master   42m   v1.18.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=ip-10-0-1-101,kubernetes.io/os=linux,node-role.kubernetes.io/master=
ip-10-0-1-102   Ready    <none>   42m   v1.18.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,disk=ssd,kubernetes.io/arch=amd64,kubernetes.io/hostname=ip-10-0-1-102,kubernetes.io/os=linux
ip-10-0-1-103   Ready    <none>   42m   v1.18.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=ip-10-0-1-103,kubernetes.io/os=linux
cloud_user@ip-10-0-1-101:~$ vi pod.yml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$ kubectl apply -f po.dyml
error: the path "po.dyml" does not exist
cloud_user@ip-10-0-1-101:~$ kubectl apply -f pod.yml
pod/nginx created
cloud_user@ip-10-0-1-101:~$ kubectl get po -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP                NODE            NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          10s   192.168.163.196   ip-10-0-1-102   <none>           <none>
