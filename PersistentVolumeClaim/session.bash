cloud_user@ip-10-0-1-101:~$ kubectl get nodes
NAME            STATUS   ROLES    AGE   VERSION
ip-10-0-1-101   Ready    master   63m   v1.13.3
ip-10-0-1-102   Ready    <none>   63m   v1.13.3
cloud_user@ip-10-0-1-101:~$ kubectl get ns
NAME          STATUS   AGE
default       Active   65m
kube-public   Active   65m
kube-system   Active   65m
web           Active   64m
cloud_user@ip-10-0-1-101:~$ kubectl get pv
NAME      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    REASON   AGE
data-pv   1Gi        RWO            Retain           Available           local-storage            65m
cloud_user@ip-10-0-1-101:~$ vi data-pvc.yml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$ kubectl apply -f data-pvc.yml
error: unable to recognize "data-pvc.yml": no matches for kind "PersistantVolumeClaim" in version "v1"
cloud_user@ip-10-0-1-101:~$ vi data-pvc.yml
cloud_user@ip-10-0-1-101:~$ kubectl apply -f data-pvc.yml
persistentvolumeclaim/data-pvc created
cloud_user@ip-10-0-1-101:~$ kubectl get pvc
No resources found.
cloud_user@ip-10-0-1-101:~$ kubectl get pvc -n web
NAME       STATUS   VOLUME    CAPACITY   ACCESS MODES   STORAGECLASS    AGE
data-pvc   Bound    data-pv   1Gi        RWO            local-storage   17s
cloud_user@ip-10-0-1-101:~$ kubectl run data-pod --image=busybox:1.28 --restart=Never -o yaml --dry-run -- /bin/sh -c 'sleep 3600' > data-pod.yaml
cloud_user@ip-10-0-1-101:~$ ls
data-pod.yaml  data-pvc.yml
cloud_user@ip-10-0-1-101:~$ vi data-p
data-pod.yaml  data-pvc.yml
cloud_user@ip-10-0-1-101:~$ vi data-pod.yaml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$ kubectl apply -f data-pod.yaml
pod/data-pod created
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
NAME       READY   STATUS              RESTARTS   AGE
data-pod   0/1     ContainerCreating   0          9s
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
NAME       READY   STATUS    RESTARTS   AGE
data-pod   1/1     Running   0          13s
cloud_user@ip-10-0-1-101:~$ kubectl exec -it data-pod -n web -- sh
/ # cp /etc/passwd /tmp/data/passwd
/ # ls /tmp/data
passwd
/ # exit
cloud_user@ip-10-0-1-101:~$ kubectl delete pod data-pod -n web
pod "data-pod" deleted

^[[A^[[B
^C
cloud_user@ip-10-0-1-101:~$ ls
data-pod.yaml  data-pvc.yml
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
No resources found.
cloud_user@ip-10-0-1-101:~$ vi data-pod.yaml
cloud_user@ip-10-0-1-101:~$ kubectl apply -f data-pod.yaml
pod/data-pod2 created
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
NAME        READY   STATUS    RESTARTS   AGE
data-pod2   1/1     Running   0          10s
cloud_user@ip-10-0-1-101:~$ kubectl exec -it data-pod2 -n web -- sh
/ # ls /tmp/data
passwd
/ # exit
cloud_user@ip-10-0-1-101:~$ echo 'data persisted after deleting the original pod, meaning that the persistent volume storage we added works'
data persisted after deleting the original pod, meaning that the persistent volume storage we added works
