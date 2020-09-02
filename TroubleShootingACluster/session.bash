cloud_user@ip-10-0-1-101:~$ curl localhost:30080
curl: (7) Failed to connect to localhost port 30080: Connection refused
cloud_user@ip-10-0-1-101:~$ sudo -i
[sudo] password for cloud_user:
root@ip-10-0-1-101:~# kubectl describe oauth-provider -n gem
error: the server doesn't have a resource type "oauth-provider"
root@ip-10-0-1-101:~# kubectl describe service oauth-provider -n gem
Name:                     oauth-provider
Namespace:                gem
Labels:                   <none>
Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                            {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"oauth-provider","namespace":"gem"},"spec":{"ports":[{"nodePort":3...
Selector:                 role=oauth
Type:                     NodePort
IP:                       10.106.76.15
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
root@ip-10-0-1-101:~# kubectl get pods --all-namespaces --show-labels
NAMESPACE     NAME                                    READY   STATUS             RESTARTS   AGE     LABELS
gem           bowline                                 0/1     ImagePullBackOff   0          6m6s    role=oauth
gem           hitch                                   0/1     ImagePullBackOff   0          6m6s    role=ws
kube-system   coredns-54ff9cd656-cvnrq                1/1     Running            0          6m13s   k8s-app=kube-dns,pod-template-hash=54ff9cd656
kube-system   coredns-54ff9cd656-gcmw4                1/1     Running            0          6m13s   k8s-app=kube-dns,pod-template-hash=54ff9cd656
kube-system   etcd-ip-10-0-1-101                      1/1     Running            0          5m13s   component=etcd,tier=control-plane
kube-system   kube-apiserver-ip-10-0-1-101            1/1     Running            0          5m30s   component=kube-apiserver,tier=control-plane
kube-system   kube-controller-manager-ip-10-0-1-101   1/1     Running            0          5m37s   component=kube-controller-manager,tier=control-plane
kube-system   kube-flannel-ds-amd64-dgjcx             1/1     Running            1          5m46s   app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-flannel-ds-amd64-wqmdw             1/1     Running            0          6m7s    app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-flannel-ds-amd64-xqqpq             1/1     Running            0          6m6s    app=flannel,controller-revision-hash=79b77f58cc,pod-template-generation=1,tier=node
kube-system   kube-proxy-9fhs7                        1/1     Running            0          5m46s   controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-proxy-btb6s                        1/1     Running            0          6m6s    controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-proxy-hg2kx                        1/1     Running            0          6m13s   controller-revision-hash=796f594d99,k8s-app=kube-proxy,pod-template-generation=1
kube-system   kube-scheduler-ip-10-0-1-101            1/1     Running            0          5m15s   component=kube-scheduler,tier=control-plane
pebble        square                                  1/1     Running            0          6m6s    role=db
root@ip-10-0-1-101:~# vi /usr/ckad/broken-object-name.txt
root@ip-10-0-1-101:~# root@ip-10-0-1-101:~# kubectl get pod bowline -n gem -o json
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "annotations": {
            "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Pod\",\"metadata\":{\"annotations\":{},\"labels\":{\"role\":\"oauth\"},\"name\":\"bowline\",\"namespace\":\"gem\"},\"spec\":{\"containers\":[{\"image\":\"ninx:1.15.9\",\"name\":\"nginx\"}]}}\n"
        },
        "creationTimestamp": "2020-09-02T17:06:59Z",
        "labels": {
            "role": "oauth"
        },
        "name": "bowline",
        "namespace": "gem",
        "resourceVersion": "1239",
        "selfLink": "/api/v1/namespaces/gem/pods/bowline",
        "uid": "b66212f1-ed3e-11ea-adad-0eec24c53ad9"
    },
    "spec": {
        "containers": [
            {
                "image": "ninx:1.15.9",
                "imagePullPolicy": "IfNotPresent",
                "name": "nginx",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "default-token-29npb",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "nodeName": "ip-10-0-1-102",
        "priority": 0,
        "restartPolicy": "Always",
        "schedulerName": "default-scheduler",
        "securityContext": {},
        "serviceAccount": "default",
        "serviceAccountName": "default",
        "terminationGracePeriodSeconds": 30,
        "tolerations": [
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/not-ready",
                "operator": "Exists",
                "tolerationSeconds": 300
            },
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/unreachable",
                "operator": "Exists",
                "tolerationSeconds": 300
            }
        ],
        "volumes": [
            {
                "name": "default-token-29npb",
                "secret": {
                    "defaultMode": 420,
                    "secretName": "default-token-29npb"
                }
            }
        ]
    },
    "status": {
        "conditions": [
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2020-09-02T17:07:08Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2020-09-02T17:07:08Z",
                "message": "containers with unready status: [nginx]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2020-09-02T17:07:08Z",
                "message": "containers with unready status: [nginx]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2020-09-02T17:07:09Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "image": "ninx:1.15.9",
                "imageID": "",
                "lastState": {},
                "name": "nginx",
                "ready": false,
                "restartCount": 0,
                "state": {
                    "waiting": {
                        "message": "Back-off pulling image \"ninx:1.15.9\"",
                        "reason": "ImagePullBackOff"
                    }
                }
            }
        ],
        "hostIP": "10.0.1.102",
        "phase": "Pending",
        "podIP": "10.244.1.5",
        "qosClass": "BestEffort",
        "startTime": "2020-09-02T17:07:08Z"
    }
}
root@ip-10-0-1-101:~# kubectl get pod bowline -n gem -o json > /usr/ckad/broken-object.json
root@ip-10-0-1-101:~# kubectl describe pod bowline -n gem
Name:               bowline
Namespace:          gem
Priority:           0
PriorityClassName:  <none>
Node:               ip-10-0-1-102/10.0.1.102
Start Time:         Wed, 02 Sep 2020 17:07:08 +0000
Labels:             role=oauth
Annotations:        kubectl.kubernetes.io/last-applied-configuration:
                      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"role":"oauth"},"name":"bowline","namespace":"gem"},"spec":{"contai...
Status:             Pending
IP:                 10.244.1.5
Containers:
  nginx:
    Container ID:
    Image:          ninx:1.15.9
    Image ID:
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-29npb (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  default-token-29npb:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-29npb
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason                  Age                     From                    Message
  ----     ------                  ----                    ----                    -------
  Warning  FailedScheduling        8m48s (x8 over 8m58s)   default-scheduler       0/2 nodes are available: 2 node(s) had taints that the pod didn't tolerate.
  Normal   Scheduled               8m48s                   default-scheduler       Successfully assigned gem/bowline to ip-10-0-1-102
  Warning  FailedCreatePodSandBox  8m46s                   kubelet, ip-10-0-1-102  Failed create pod sandbox: rpc error: code = Unknown desc = failed to set up sandbox container "2da496135bcb8ee197d467e73407cccbefc377b229214aa26c2cbd9e7bd5a432" network for pod "bowline": NetworkPlugin cni failed to set up pod "bowline_gem" network: open /run/flannel/subnet.env: no such file or directory
  Normal   SandboxChanged          8m44s (x2 over 8m46s)   kubelet, ip-10-0-1-102  Pod sandbox changed, it will be killed and re-created.
  Warning  Failed                  8m3s (x3 over 8m44s)    kubelet, ip-10-0-1-102  Failed to pull image "ninx:1.15.9": rpc error: code = Unknown desc = Error response from daemon: pull access denied for ninx, repository does not exist or may require 'docker login'
  Warning  Failed                  8m3s (x3 over 8m44s)    kubelet, ip-10-0-1-102  Error: ErrImagePull
  Normal   BackOff                 7m33s (x6 over 8m42s)   kubelet, ip-10-0-1-102  Back-off pulling image "ninx:1.15.9"
  Normal   Pulling                 7m21s (x4 over 8m45s)   kubelet, ip-10-0-1-102  pulling image "ninx:1.15.9"
  Warning  Failed                  3m43s (x22 over 8m42s)  kubelet, ip-10-0-1-102  Error: ImagePullBackOff
root@ip-10-0-1-101:~# kubectl edit pod bowline -n gem
pod/bowline edited
root@ip-10-0-1-101:~# kubectl get pods -n gem
NAME      READY   STATUS             RESTARTS   AGE
bowline   1/1     Running            0          10m
hitch     0/1     ImagePullBackOff   0          10m
root@ip-10-0-1-101:~# curl localhost:30080
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
