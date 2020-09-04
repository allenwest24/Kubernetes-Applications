cloud_user@ip-10-0-1-101:~$ vi fruit-service-ambassador-config.yml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$
cloud_user@ip-10-0-1-101:~$ kubectl apply -f fruit-service-ambassador-config.yml
configmap/fruit-service-ambassador-config created
cloud_user@ip-10-0-1-101:~$ vi fruit-service.yml
cloud_user@ip-10-0-1-101:~$ cloud_user@ip-10-0-1-101:~$ kubectl apply -f fruit-service.yml
pod/fruit-service created
cloud_user@ip-10-0-1-101:~$ vi busybox.yml
cloud_user@ip-10-0-1-101:~$ kubectl get pods
