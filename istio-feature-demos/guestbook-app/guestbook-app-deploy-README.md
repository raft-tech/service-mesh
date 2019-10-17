# Guestbook application deployment
Guestbook is a multi-tier web application. Application has a web front end and redis backend

We will deploy v1 and v2 versions of guestbook

**Step1: Create a namespace called istio-demo**
```
kubectl create ns istio-demo
```

**Step2: Label istio-demo namespace for automatic istio-proxy sidecar injection**
By labeling the namespace, istio sidecar is automatically attached to the application
```
kubectl label ns istio-demo istio-injection=enabled
```

**Step3: Deploy v1 version of guestbook application**
```
kubectl apply -f istio-feature-demos/guestbook-app/v1/manifests -n istio-demo
```

**Step4: Deploy v2 version of guestbook application**
```
kubectl apply -f istio-feature-demos/guestbook-app/v2/manifests -n istio-demo
```
```
output: v1 and v2 versions
kubectl get po -n istio-demo
NAME                            READY   STATUS    RESTARTS   AGE
guestbook-v1-6844f4c979-5mjb7   2/2     Running   0          11h
guestbook-v1-6844f4c979-9nt42   2/2     Running   0          11h
guestbook-v1-6844f4c979-czrx6   2/2     Running   0          11h
guestbook-v2-7997977544-6dv8s   2/2     Running   0          11h
guestbook-v2-7997977544-jtqvl   2/2     Running   0          11h
guestbook-v2-7997977544-l569v   2/2     Running   0          11h
redis-master-74b4bf6796-7dcwg   2/2     Running   0          11h
redis-slave-65c87ffc7f-4g55v    2/2     Running   0          11h
redis-slave-65c87ffc7f-kbm47    2/2     Running   0          11h
```

**Step5: Expose the application via Ingress gateway**
Create a gateway resource and a virtualservice resource on the cluster
guestbook-gateway-virtualservice.yaml
-------------------------------------
```
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: guestbook-gateway
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
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: virtual-service-guestbook
spec:
  hosts:
    - '*'
  gateways:
    - guestbook-gateway
  http:
    - route:
        - destination:
            host: guestbook
```

**Step6: Access the guestbook application using ingress gateway public ip**
```
kubectl get svc -n istio-system -l istio=ingressgateway
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                                                                                                                                      AGE
istio-ingressgateway   LoadBalancer   10.59.246.28   35.x.x.174   15020:30204/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:31399/TCP,15030:32281/TCP,15031:31950/TCP,15032:31306/TCP,15443:30683/TCP   35h
```
```
Access the application: http://35.x.x.174
```
**This concludes deploying v1 and v2 versions of guestbook application and expose the application using istio's ingress gateway**
