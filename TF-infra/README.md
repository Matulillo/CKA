# CKA
Basic terraform project template to deploy K8s infra. 
It enables the creation of AWS basic cloud enviroments with mainly: VPC,Subnets,routing config, instances, security groups, etc.. using custom modules.  

##############################################
### Provide access to control plane from local
##############################################
# access to the remote control plane :
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


#1. Copy the k config from control plane to local
 scp -i C:\Users\Carlos\.ssh\carlos.pem ec2-user@51.92.41.125:.kube/config C:\Users\Carlos\.kube\config

#2. change this in local config 
 cluster:
    #certificate-authority-data: XXXXX
    server: https://localhost:6443
    insecure-skip-tls-verify: true
  name: kubernetes

#3. Make a tunnel 
ssh -i "C:\path\to\your-key.pem" -L 6443:localhost:6443 ec2-user@51.92.41.125

#4. Test the kubectl access
C:\Users\Carlos\My Drive\Projects\CKA\TF-infra\Dev [main ≡ +1 ~1 -0 !]> k get nodes
NAME                                         STATUS   ROLES           AGE   VERSION
ip-10-10-10-10.eu-south-2.compute.internal   Ready    control-plane   51m   v1.28.15
ip-10-10-10-11.eu-south-2.compute.internal   Ready    <none>          44m   v1.28.15
C:\Users\Carlos\My Drive\Projects\CKA\TF-infra\Dev [main ≡ +1 ~1 -0 !]> k get pods -n kube-system
NAME                                                                 READY   STATUS    RESTARTS   AGE
coredns-5dd5756b68-jjbff                                             1/1     Running   0          54m
coredns-5dd5756b68-nxqsv                                             1/1     Running   0          54m
etcd-ip-10-10-10-10.eu-south-2.compute.internal                      1/1     Running   0          55m
kube-apiserver-ip-10-10-10-10.eu-south-2.compute.internal            1/1     Running   0          55m
kube-controller-manager-ip-10-10-10-10.eu-south-2.compute.internal   1/1     Running   0          55m
kube-proxy-vxtr9                                                     1/1     Running   0          48m
kube-proxy-wfkt4                                                     1/1     Running   0          54m
kube-scheduler-ip-10-10-10-10.eu-south-2.compute.internal            1/1     Running   0          55m

## Adjustments to work with kubectl from control plane itself 
[root@ip-10-10-10-10 ec2-user]#  export KUBECONFIG=/etc/kubernetes/admin.conf
[root@ip-10-10-10-10 ec2-user]# kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://10.10.10.10:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
[root@ip-10-10-10-10 ec2-user]# kubectl get nodes
NAME                                         STATUS   ROLES           AGE    VERSION
ip-10-10-10-10.eu-south-2.compute.internal   Ready    control-plane   14m    v1.28.15
ip-10-10-10-11.eu-south-2.compute.internal   Ready    <none>          4m2s   v1.28.15
[root@ip-10-10-10-10 ec2-user]# kubectl get pods -n kube-system
NAME                                                                 READY   STATUS    RESTARTS   AGE
coredns-5dd5756b68-2l475                                             1/1     Running   0          15m
coredns-5dd5756b68-qk8vc                                             1/1     Running   0          15m
etcd-ip-10-10-10-10.eu-south-2.compute.internal                      1/1     Running   0          15m
kube-apiserver-ip-10-10-10-10.eu-south-2.compute.internal            1/1     Running   0          15m
kube-controller-manager-ip-10-10-10-10.eu-south-2.compute.internal   1/1     Running   0          15m
kube-proxy-dx2ct                                                     1/1     Running   0          4m23s
kube-proxy-qsbhl                                                     1/1     Running   0          15m
kube-scheduler-ip-10-10-10-10.eu-south-2.compute.internal            1/1     Running   0          15m

