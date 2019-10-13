# Istio Installation on Minikube
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

# Steps to Install Istio on Minikube
**Step1: Get Latest version of Istio by running this command**

```
curl -L https://git.io/getLatestIstio | sh -
```

**Step2: Navigate to Istio directory (In this example istio-1.3.2)**
```
cd istio-1.3.2
```

**Step2: Check Istio Version**
```
./bin/istioctl version
```
```
Output: (We have not installed Istio yet so you will see no Istio pods are installed)
2019-10-13T15:13:25.516998Z	warn	will use `--remote=false` to retrieve version info due to `no Istio pods in namespace "istio-system"`
1.3.2
```

**Step3: Check if Kubernetes cluster is ready for Istio Installation**
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

**Step4: Install MetalLB on Minikube**
*MetalLB is a load balancer designed to run on and to work with Kubernetes and it will allow you to use the type LoadBalancer when you declare a service*

*As we are using minikube we dont get to expose our service to internet and we use NodePort. To avoid NodePort and to expose our service to internet we need service type: LoadBalancer; MetalLB provides that solution on Minikube*

*A new namespace will be created called metallb-system*

```
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml
```

**Step5: Create a ConfigMap for MetalLB that has minikube ip address**
```
minikube ip
192.168.99.102
```

```
ConfigMap: (Under addresses you should see I have added my minikube ip with /24 CIDR)
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: custom-ip-space
      protocol: layer2
      addresses:
      - 192.168.99.102/24
```

**Step6: Install Istio on Minikube**
```
kubectl create -f istio-1.3.2/install/kubernetes/istio-demo.yaml
```

**Step7: Validate Istio Install by checking pods in istio-system namespace**
*When Istio is installed a new namespace called istio-system will be created and istio components will be installed in that namespace*
```
kubectl get pod -n istio-system
```

```
output:
kubectl get po -n istio-system
NAME                                      READY   STATUS      RESTARTS   AGE
grafana-59d57c5c56-dmdmg                  1/1     Running     0          32m
istio-citadel-658567496c-gzz54            1/1     Running     0          32m
istio-egressgateway-54f65d655-r6vj5       1/1     Running     0          32m
istio-galley-9695fbd77-xpr8s              1/1     Running     0          32m
istio-grafana-post-install-1.3.2-tjpcd    0/1     Completed   0          32m
istio-ingressgateway-6b49645788-6jhzn     1/1     Running     0          32m
istio-pilot-8486d49647-cbzz2              2/2     Running     0          32m
istio-policy-6bf887bb5b-2692t             2/2     Running     3          32m
istio-security-post-install-1.3.2-mkvqd   0/1     Completed   0          32m
istio-sidecar-injector-54d9c5b6f8-8kssr   1/1     Running     0          32m
istio-telemetry-6bf94f9d46-mtggv          2/2     Running     4          32m
istio-tracing-6bbdc67d6c-vz487            1/1     Running     0          32m
kiali-8c9d6fbf6-f7c4m                     1/1     Running     0          32m
prometheus-7d7b9f7844-7xnlq               1/1     Running     0          32m
```

**Step8: Because of MetalLB istio-ingressgateway got an External IP Address**
```
kubectl get svc -n istio-system
```

```
output:
NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)                                                                                                                                      AGE
grafana                  ClusterIP      10.103.52.14     <none>         3000/TCP                                                                                                                                     38m
istio-citadel            ClusterIP      10.106.206.218   <none>         8060/TCP,15014/TCP                                                                                                                           38m
istio-egressgateway      ClusterIP      10.107.220.140   <none>         80/TCP,443/TCP,15443/TCP                                                                                                                     38m
istio-galley             ClusterIP      10.105.250.127   <none>         443/TCP,15014/TCP,9901/TCP                                                                                                                   38m
istio-ingressgateway     LoadBalancer   10.104.221.171   192.168.99.0   15020:30181/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:31744/TCP,15030:32765/TCP,15031:30075/TCP,15032:32291/TCP,15443:31957/TCP   38m
istio-pilot              ClusterIP      10.108.124.143   <none>         15010/TCP,15011/TCP,8080/TCP,15014/TCP                                                                                                       38m
istio-policy             ClusterIP      10.108.67.107    <none>         9091/TCP,15004/TCP,15014/TCP                                                                                                                 38m
istio-sidecar-injector   ClusterIP      10.97.115.142    <none>         443/TCP,15014/TCP                                                                                                                            38m
istio-telemetry          ClusterIP      10.104.120.215   <none>         9091/TCP,15004/TCP,15014/TCP,42422/TCP                                                                                                       38m
jaeger-agent             ClusterIP      None             <none>         5775/UDP,6831/UDP,6832/UDP                                                                                                                   38m
jaeger-collector         ClusterIP      10.108.3.48      <none>         14267/TCP,14268/TCP                                                                                                                          38m
jaeger-query             ClusterIP      10.110.195.21    <none>         16686/TCP                                                                                                                                    38m
kiali                    ClusterIP      10.97.98.120     <none>         20001/TCP                                                                                                                                    38m
prometheus               ClusterIP      10.100.74.83     <none>         9090/TCP                                                                                                                                     38m
tracing                  ClusterIP      10.109.103.36    <none>         80/TCP                                                                                                                                       38m
zipkin                   ClusterIP      10.107.11.143    <none>         9411/TCP                                                                                                                                     38m
```

# This concludes Istio Install on Minikube; We shall now explore istio's capabilities by deploying microservice applications on kubernetes platform
