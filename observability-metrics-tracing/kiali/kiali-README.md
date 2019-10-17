# Kiali
**Kiali is an observability console for Istio with service mesh configuration capabilities**

Kiali gives us a good view of what microservices are part of Istio mesh, their performance and connection details

Kiali provides detailed metrics, and a basic Grafana integration is available for advanced queries

Distributed tracing is provided by integrating Jaeger

**Kiali is deployed when we install Istio on GKE**

**Step1: Validate if kiali pod is running in istio-system namespace or not**
```
kubectl get pods -n istio-system
```
```
output:
kiali-7dd44f7696-jtjtj                    1/1     Running     0          16h
```

**Step2: Access kiali console using port-forwarding from the cluster**
```
kubectl port-forward \
    $(kubectl get pod -n istio-system -l app=kiali \
    -o jsonpath='{.items[0].metadata.name}') \
    -n istio-system 20001
```

**Step3: Access kiali console from http://localhost:20001**
username: admin
password: admin

**kiali is a powerful console that complements Istio**
