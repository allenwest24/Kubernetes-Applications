cloud_user@ip-10-0-1-101:~$ kubectl get nodes
NAME            STATUS   ROLES    AGE   VERSION
ip-10-0-1-101   Ready    master   35m   v1.13.3
ip-10-0-1-102   Ready    <none>   35m   v1.13.3
ip-10-0-1-103   Ready    <none>   35m   v1.13.3
cloud_user@ip-10-0-1-101:~$ echo "create a webapp in the namespace and verify connectivity"
create a webapp in the namespace and verify connectivity
cloud_user@ip-10-0-1-101:~$ kubectl get ns
NAME          STATUS   AGE
default       Active   36m
kube-public   Active   36m
kube-system   Active   36m
cloud_user@ip-10-0-1-101:~$ echo "no namespace"
no namespace
cloud_user@ip-10-0-1-101:~$ kubectl get ns
NAME          STATUS   AGE
default       Active   36m
kube-public   Active   36m
kube-system   Active   36m
cloud_user@ip-10-0-1-101:~$ kubectl create ns web
namespace/web created
cloud_user@ip-10-0-1-101:~$ kubectl get ns
NAME          STATUS   AGE
default       Active   37m
kube-public   Active   37m
kube-system   Active   37m
web           Active   3s
cloud_user@ip-10-0-1-101:~$ kubectl run webapp --image=linuxacademycontent/podofminerva:latest --port=80 --replicas=3 -n web
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/webapp created
cloud_user@ip-10-0-1-101:~$ get deployments -n web

Command 'get' not found, but there are 18 similar ones.

cloud_user@ip-10-0-1-101:~$ get deploy -n web


Command 'get' not found, but there are 18 similar ones.

cloud_user@ip-10-0-1-101:~$
cloud_user@ip-10-0-1-101:~$ kubectl get deployments -n web
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
webapp   3/3     3            3           44s
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
NAME                      READY   STATUS    RESTARTS   AGE
webapp-6b75f6fbf7-2s4db   1/1     Running   0          55s
webapp-6b75f6fbf7-7t2lx   1/1     Running   0          55s
webapp-6b75f6fbf7-sh9dd   1/1     Running   0          55s
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web -o wide
NAME                      READY   STATUS    RESTARTS   AGE    IP           NODE            NOMINATED NODE   READINESS GATES
webapp-6b75f6fbf7-2s4db   1/1     Running   0          109s   10.244.2.2   ip-10-0-1-103   <none>           <none>
webapp-6b75f6fbf7-7t2lx   1/1     Running   0          109s   10.244.1.3   ip-10-0-1-102   <none>           <none>
webapp-6b75f6fbf7-sh9dd   1/1     Running   0          109s   10.244.1.2   ip-10-0-1-102   <none>           <none>
cloud_user@ip-10-0-1-101:~$ kubectl run busybox --image=busybox --rm -it --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
/ # wget -O- 10.244.1.3:80
Connecting to 10.244.1.3:80 (10.244.1.3:80)
writing to stdout
<h1>Welcome to the Pod of Minerva</h1>
-                    100% |***********************************|    39  0:00:00 ETA
written to stdout
/ # exit
pod "busybox" deleted
cloud_user@ip-10-0-1-101:~$ kubectl expose deployment/webapp --port=80 --target-port=80 --type=NodePort -n web --dry-run -o yaml > web-service.yml
cloud_user@ip-10-0-1-101:~$ ls
web-service.yml
cloud_user@ip-10-0-1-101:~$ vi web-service.yml
cloud_user@ip-10-0-1-101:~$ kubectl apply
Error: required flag(s) "filename" not set


Examples:
  # Apply the configuration in pod.json to a pod.
  kubectl apply -f ./pod.json

  # Apply the JSON passed into stdin to a pod.
  cat pod.json | kubectl apply -f -

  # Note: --prune is still in Alpha
  # Apply the configuration in manifest.yaml that matches label app=nginx and delete all the other resources that are not in the file and match label app=nginx.
  kubectl apply --prune -f manifest.yaml -l app=nginx

  # Apply the configuration in manifest.yaml and delete all the other configmaps that are not in the file.
  kubectl apply --prune -f manifest.yaml --all --prune-whitelist=core/v1/ConfigMap

Available Commands:
  edit-last-applied Edit latest last-applied-configuration annotations of a resource/object
  set-last-applied  Set the last-applied-configuration annotation on a live object to match the contents of a file.
  view-last-applied View latest last-applied-configuration annotations of a resource/object

Options:
      --all=false: Select all resources in the namespace of the specified resource types.
      --allow-missing-template-keys=true: If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.
      --cascade=true: If true, cascade the deletion of the resources managed by this resource (e.g. Pods created by a ReplicationController).  Default true.
      --dry-run=false: If true, only print the object that would be sent, without sending it.
  -f, --filename=[]: that contains the configuration to apply
      --force=false: Only used when grace-period=0. If true, immediately remove resources from API and bypass graceful deletion. Note that immediate deletion of some resources may result in inconsistency or data loss and requires confirmation.
      --grace-period=-1: Period of time in seconds given to the resource to terminate gracefully. Ignored if negative. Set to 1 for immediate shutdown. Can only be set to 0 when --force is true (force deletion).
      --include-uninitialized=false: If true, the kubectl command applies to uninitialized objects. If explicitly set to false, this flag overrides other flags that make the kubectl commands apply to uninitialized objects, e.g., "--all". Objects with empty metadata.initializers are regarded as initialized.
      --openapi-patch=true: If true, use openapi to calculate diff when the openapi presents and the resource can be found in the openapi spec. Otherwise, fall back to use baked-in types.
  -o, --output='': Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.
      --overwrite=true: Automatically resolve conflicts between the modified and live configuration by using values from the modified configuration
      --prune=false: Automatically delete resource objects, including the uninitialized ones, that do not appear in the configs and are created by either apply or create --save-config. Should be used with either -l or --all.
      --prune-whitelist=[]: Overwrite the default whitelist with <group/version/kind> for --prune
      --record=false: Record current kubectl command in the resource annotation. If set to false, do not record the command. If set to true, record the command. If not set, default to updating the existing annotation value only if one already exists.
  -R, --recursive=false: Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests organized within the same directory.
  -l, --selector='': Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
      --server-dry-run=false: If true, request will be sent to server with dry-run flag, which means the modifications won't be persisted. This is an alpha feature and flag.
      --template='': Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates [http://golang.org/pkg/text/template/#pkg-overview].
      --timeout=0s: The length of time to wait before giving up on a delete, zero means determine a timeout from the size of the object
      --validate=true: If true, use a schema to validate the input before sending it
      --wait=false: If true, wait for resources to be gone before returning. This waits for finalizers.

Usage:
  kubectl apply -f FILENAME [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).

required flag(s) "filename" not set
cloud_user@ip-10-0-1-101:~$ kubectl apply -f web-service.yml
service/web-service created
cloud_user@ip-10-0-1-101:~$ kubectl get svc -n web
NAME          TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
web-service   NodePort   10.105.211.211   <none>        80:30080/TCP   21s
cloud_user@ip-10-0-1-101:~$ curl localhost:30080
<h1>Welcome to the Pod of Minerva</h1>
cloud_user@ip-10-0-1-101:~$ kubectl edit deployment webapp
Error from server (NotFound): deployments.extensions "webapp" not found
cloud_user@ip-10-0-1-101:~$ kubectl edit deploy webapp
Error from server (NotFound): deployments.extensions "webapp" not found
cloud_user@ip-10-0-1-101:~$ kubectl edit deploy webapp -n web
deployment.extensions/webapp edited
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
NAME                      READY   STATUS    RESTARTS   AGE
webapp-66fc5c6d58-ncc4w   0/1     Running   0          13s
webapp-66fc5c6d58-xrxzk   1/1     Running   0          22s
webapp-6b75f6fbf7-2s4db   1/1     Running   0          10m
webapp-6b75f6fbf7-sh9dd   1/1     Running   0          10m
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
NAME                      READY   STATUS        RESTARTS   AGE
webapp-66fc5c6d58-ncc4w   1/1     Running       0          20s
webapp-66fc5c6d58-vhmzr   0/1     Running       0          7s
webapp-66fc5c6d58-xrxzk   1/1     Running       0          29s
webapp-6b75f6fbf7-2s4db   1/1     Running       0          10m
webapp-6b75f6fbf7-sh9dd   0/1     Terminating   0          10m
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
NAME                      READY   STATUS        RESTARTS   AGE
webapp-66fc5c6d58-ncc4w   1/1     Running       0          26s
webapp-66fc5c6d58-vhmzr   1/1     Running       0          13s
webapp-66fc5c6d58-xrxzk   1/1     Running       0          35s
webapp-6b75f6fbf7-2s4db   1/1     Terminating   0          10m
cloud_user@ip-10-0-1-101:~$ kubectl get pods -n web
NAME                      READY   STATUS    RESTARTS   AGE
webapp-66fc5c6d58-ncc4w   1/1     Running   0          30s
webapp-66fc5c6d58-vhmzr   1/1     Running   0          17s
webapp-66fc5c6d58-xrxzk   1/1     Running   0          39s
cloud_user@ip-10-0-1-101:~$ kubectl get pod webapp-66fc5c6d58-ncc4w -n web -o yml --export
error: unable to match a printer suitable for the output format "yml", allowed formats are: custom-columns,custom-columns-file,go-template,go-template-file,json,jsonpath,jsonpath-file,name,template,templatefile,wide,yaml
cloud_user@ip-10-0-1-101:~$ kubectl get pod webapp-66fc5c6d58-ncc4w -n web -o yaml --export
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  generateName: webapp-66fc5c6d58-
  labels:
    pod-template-hash: 66fc5c6d58
    run: webapp
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: webapp-66fc5c6d58
    uid: 72ea34e6-f2ad-11ea-98cf-029657920bd3
  selfLink: /api/v1/namespaces/web/pods/webapp-66fc5c6d58-ncc4w
spec:
  containers:
  - image: linuxacademycontent/podofminerva:latest
    imagePullPolicy: Always
    livenessProbe:
      failureThreshold: 3
      httpGet:
        path: /healthz
        port: 8081
        scheme: HTTP
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 1
    name: webapp
    ports:
    - containerPort: 80
      protocol: TCP
    readinessProbe:
      failureThreshold: 3
      httpGet:
        path: /
        port: 80
        scheme: HTTP
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 1
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-2vf99
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: ip-10-0-1-102
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: default-token-2vf99
    secret:
      defaultMode: 420
      secretName: default-token-2vf99
status:
  phase: Pending
  qosClass: BestEffort
