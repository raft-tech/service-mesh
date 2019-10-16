# Deploy a microservice application on kubernetes platform

The application that we are deploying is a **sentiment analyzer** application
The application is composed of 4 microservices
1. SA-Frontend (Its a nginx frontend based app written in ReactJS)
2. SA-webapp (Handles all incoming requests for sentiment analysis; Written in Spring/Java)
3. SA-logic (This app performs sentiment analysis; Written in Flask/Python)
4. SA-Feedback (Receieves feedback from users about accuracy of the analysis; Written in ASP.NET/C#)

![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/istio-feature-demos/sentiment-analyzer-app/sentiment-analyzer-app.png?raw=true)

**Application deployment on kubernetes**

**Step1: Create a namespace**
```
kubectl create namespace demo
```

**Step2: Label the namespace**
Auto sidecar injection is possible by applying label to the namespace; istio-proxy is attached to the application automatically when the application is deployed in the namespace
```
kubectl label namespace demo istio-injection=enabled
```

**Step3: Deploy the manifests**
Deploy 4 microservices from the k8-manifests folder
Clone the service mesh repo
```
kubectl apply -f istio-feature-demos/sentiment-analyzer-app/k8-manifests -n demo
```

If you look at the output each application container has istio-proxy attached to it and that is why we have 2 containers per pod
```
output:
NAME                                READY   STATUS    RESTARTS   AGE
sa-feedback-55f5dc4d9c-zmwrm        2/2     Running   0          12h
sa-frontend-558f8986-sxvzs          2/2     Running   0          12h
sa-logic-568498cb4d-2hgp6           2/2     Running   0          12h
sa-logic-568498cb4d-vwcjv           2/2     Running   0          12h
sa-web-app-599cf47c7c-hrbcx         2/2     Running   0          12h
```

**Step3: Get External IP of Ingress Gateway**
Ingress gateway is a critical component in Istio
It sits on the edge of the cluster and allows traffic that is coming into the cluster
Clients wanting to access the application will hit the Public IP of Ingress Gateway
```
kubectl get svc -n istio-system -l istio=ingressgateway
```

```
output:
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S) AGE
istio-ingressgateway   LoadBalancer   10.59.246.28   35.x.x.174   15020:30204/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:31399/TCP,15030:32281/TCP,15031:31950/TCP,15032:31306/TCP,15443:30683/TCP   12h
```

**Step4: Deploy Gateway**
Gateway is a CRD that helps us specify which ports we wish to open on the Gateway, and what virtual hosts to allow for those ports

Currently if you look at hosts field, we have allowed all hosts for this demo, but you specify a host there

gateway.yaml
------------
```
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: http-gateway
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
```

```
kubectl apply -f istio-feature-demos/sentiment-analyzer-app/istio-manifests/gateway.yaml -n demo
```
```
output:
kubectl get gateway -n demo
NAME           AGE
http-gateway   13h
```

**Step5: Create Virtual Service**
We have configured Istio Gateway to expose a specific port, expect a specific protocol on that port, and define specific hosts to serve from the port/protocol pair

When traffic comes into the gateway, we need a way to get it to a specific service within the service mesh 

VirtualService resource defines how a client talks to a specific service through its fully qualified domain name, which versions of a service are available, and other routing properties

virtualservice.yaml
-------------------
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: sa-external-services
spec:
  hosts:
  - "*"
  gateways:
  - http-gateway # 1
  http:
  - match:
    - uri:
        exact: /
    - uri:
        exact: /callback
    - uri:
        prefix: /static
    - uri:
        regex: '^.*\.(ico|png|jpg)$'
    route:
    - destination:
        host: sa-frontend # 2
        port:
          number: 80
```
```
kubectl apply -f istio-feature-demos/sentiment-analyzer-app/istio-manifests/virtualservice.yaml -n demo
```
```
output:
kubectl get virtualservice -n demo
NAME                   GATEWAYS         HOSTS   AGE
sa-external-services   [http-gateway]   [*]     13h
```

**Step5: Access the application**
Get the Public IP
```
PUBLIC_IP=$(kubectl get svc -n istio-system \
  -l app=istio-ingressgateway \
  -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')
```
```
echo $PUBLIC_IP
35.x.x.174
```
```
Access the application on your browser
HTTP://PUBLIC_IP
```

**This concludes deployment of microservice application with istio-proxy injection and application access via Ingress Gateway**