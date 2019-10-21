# Espresso application deployment
Espresso is an application consisting of 3 microservices

1. Web (frontend) - Aggregates data from product calatalog and reviews
2. Product Catalog - Contains Product Info
3. Reviews - Contains reviews of all products

All 3 microservices are written in ASP.NET core

**Step1: Create a namespace called istio-demo**
```
kubectl create ns istio-demo
```

**Step2: Label istio-demo namespace for automatic istio-proxy sidecar injection**
By labeling the namespace, istio sidecar is automatically attached to the application
```
kubectl label ns istio-demo istio-injection=enabled
```

**Step3: Deploy v1 version of espresso application**
```
kubectl apply -f istio-feature-demos/espresso-app/v1/manifests -n istio-demo
```

**Step4: Deploy v2 version of espresso application**
```
kubectl apply -f istio-feature-demos/espresso-app/v2/manifests -n istio-demo
```
```
output: v1 and v2 versions of espresso app
kubectl get po -n istio-demo

```

**Step5: Expose the application via Ingress gateway**
Create a gateway resource and a virtualservice resource on the cluster
gateway.yaml
------------
```
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: espresso-shop-gateway
spec:
  selector:
    istio: ingressgateway # use istio default controller
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
virtual-service.yaml
--------------------
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: espresso-shop
spec:
  hosts:
  - "*"
  gateways:
  - espresso-shop-gateway
  http:
  - match:
    route:
    - destination:
        host: espresso-shop-web-svc
        port:
          number: 8090

```
```
kubectl apply -f gateway.yaml -n istio-demo
kubectl apply -f virtual-service.yaml -n istio-demo
```

**Step6: Access the espresso application using ingress gateway public ip**
```
NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)  AGE
istio-ingressgateway   LoadBalancer   10.59.249.176   35.x.52.174   15020:30875/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:32077/TCP,150
30:30698/TCP,15031:31746/TCP,15032:31073/TCP,15443:31218/TCP   22m                                                                                                                                    
```
```
Access the application: http://35.x.52.174
```
**This concludes deploying v1 and v2 versions of espresso application and expose the application using istio's ingress gateway**
