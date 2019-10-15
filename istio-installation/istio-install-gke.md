# Istio Installation on GKE
Istio is an open source service mesh designed to make communication among microservices reliable, transparent, and secure

Istio intercepts the external and internal traffic targeting the services deployed on kubernetes platform

# Istio's capabilities:
1. Automatic load balancing for HTTP, gRPC, WebSocket, and TCP traffic
2. Fine-grained control of traffic behavior with rich routing rules, retries, failovers, and fault injection
2. Secure service-to-service communication
3. Automated logging of metrics, logs and traces for all traffic within a cluster including ingress and egress
4. Enforcing a policy for access controls, rate limits and quotas

# Istio's Core Features
1. Traffic Management
2. Security
3. Observability

# Steps to Install Istio on GKE
**Step1: Get Latest version of Istio by running this command**
```
curl -L https://git.io/getLatestIstio | sh -
```

**Step2: Navigate to Istio directory (In this example istio-1.3.3)**
```
cd istio-1.3.3
```

**Step3: Check Istio Version**
```
./bin/istioctl version
```

**Step4: Check if GKE cluster is ready for Istio Installation**
```
./bin/istioctl verify-install
```
```
Output:
Checking the cluster to make sure it is ready for Istio installation...
#1. Kubernetes-api
-----------------------
Can initialize the Kubernetes client.
Can query the Kubernetes API Server.

#2. Kubernetes-version
-----------------------
Istio is compatible with Kubernetes: v1.15.0.

#3. Istio-existence
-----------------------
Istio will be installed in the istio-system namespace.

#4. Kubernetes-setup
-----------------------
Can create necessary Kubernetes configurations: Namespace,ClusterRole,ClusterRoleBinding,CustomResourceDefinition,Role,ServiceAccount,Service,Deployments,ConfigMap.

#5. Sidecar-Injector
-----------------------
This Kubernetes cluster supports automatic sidecar injection. To enable automatic sidecar injection see https://istio.io/docs/setup/kubernetes/additional-setup/sidecar-injection/#deploying-an-app

-----------------------
Install Pre-Check passed! The cluster is ready for Istio installation.
```

**Step5: Install Istio on GKE**
```
kubectl create -f istio-1.3.3/install/kubernetes/istio-demo.yaml
```

**Step9: Validate Istio Install by checking pods in istio-system namespace**
*When Istio is installed a new namespace called istio-system will be created and istio components will be installed in that namespace*
```
kubectl get pod -n istio-system
```

```
output:
kubectl get po -n istio-system
NAME                                      READY   STATUS      RESTARTS   AGE
grafana-575c7c4784-7j479                  1/1     Running     0          5m53s
istio-citadel-6cb95997f8-4ss6v            1/1     Running     0          5m52s
istio-egressgateway-6d4f69787b-76f5l      1/1     Running     0          5m53s
istio-galley-b877d99f4-m4gcc              1/1     Running     0          5m53s
istio-grafana-post-install-1.3.3-tvdrv    0/1     Completed   0          5m56s
istio-ingressgateway-774f65f6f-rvwr7      1/1     Running     0          5m53s
istio-pilot-7f459bf88f-2px68              2/2     Running     0          5m52s
istio-policy-5bb5df64f6-99crx             2/2     Running     1          5m52s
istio-security-post-install-1.3.3-8l2kw   0/1     Completed   0          5m56s
istio-sidecar-injector-6c65cfff5-rk89f    1/1     Running     0          5m52s
istio-telemetry-c8fdf6c46-5b5g2           2/2     Running     1          5m52s
istio-tracing-8456d6548f-7cwgp            1/1     Running     0          5m52s
kiali-7dd44f7696-pd8dq                    1/1     Running     0          5m53s
prometheus-5679cb4dcd-9cz7n               1/1     Running     0          5m52s
```

**Step10: Because of MetalLB istio-ingressgateway got an External IP Address**
```
kubectl get svc -n istio-system
```

```
output:
NAME                     TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)                                                                                    
                                                  AGE
grafana                  ClusterIP      10.59.248.124   <none>          3000/TCP                                                                                   
                                                  6m26s
istio-citadel            ClusterIP      10.59.241.19    <none>          8060/TCP,15014/TCP                                                                         
                                                  6m26s
istio-egressgateway      ClusterIP      10.59.242.223   <none>          80/TCP,443/TCP,15443/TCP                                                                   
                                                  6m27s
istio-galley             ClusterIP      10.59.244.22    <none>          443/TCP,15014/TCP,9901/TCP                                                                 
                                                  6m27s
istio-ingressgateway     LoadBalancer   10.59.245.201   35.231.52.174   15020:30005/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:32444/TCP,15030:31804/TCP,
15031:30096/TCP,15032:31593/TCP,15443:31041/TCP   6m26s
istio-pilot              ClusterIP      10.59.254.21    <none>          15010/TCP,15011/TCP,8080/TCP,15014/TCP                                                     
                                                  6m26s
istio-policy             ClusterIP      10.59.246.118   <none>          9091/TCP,15004/TCP,15014/TCP                                                               
                                                  6m26s
istio-sidecar-injector   ClusterIP      10.59.243.67    <none>          443/TCP,15014/TCP                                                                          
                                                  6m26s
istio-telemetry          ClusterIP      10.59.245.96    <none>          9091/TCP,15004/TCP,15014/TCP,42422/TCP                                                     
                                                  6m26s
jaeger-agent             ClusterIP      None            <none>          5775/UDP,6831/UDP,6832/UDP                                                                 
                                                  6m24s
jaeger-collector         ClusterIP      10.59.242.78    <none>          14267/TCP,14268/TCP                                                                        
                                                  6m24s
jaeger-query             ClusterIP      10.59.244.61    <none>          16686/TCP                                                                                  
                                                  6m24s
kiali                    ClusterIP      10.59.251.232   <none>          20001/TCP                                                                                  
                                                  6m26s
prometheus               ClusterIP      10.59.254.82    <none>          9090/TCP                                                                                   
                                                  6m26s
tracing                  ClusterIP      10.59.249.32    <none>          80/TCP                                                                                     
                                                  6m24s
zipkin                   ClusterIP      10.59.254.96    <none>          9411/TCP                                                                                   
                                                  6m24s
```

# This concludes Istio Install on GKE; We shall now explore istio's capabilities by deploying microservice applications on kubernetes platform
