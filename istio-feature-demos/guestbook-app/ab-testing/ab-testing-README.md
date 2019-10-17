# A/B Testing
A/B testing is a method of performing identical tests against two versions of an application in order to determine which one performs better

We deployed v1 and v2 versions of guestbook application; To perform routing between versions we will create istio virtual service and destinationrule resources

**Virtual Service** defines set of traffic routing rules to apply when a host is defined
**DestinationRule** is a policy that is applied to the traffic intended for a service (based on versions: v1 and v2)

**Step1: Apply virtual service and destination rule manifests**
guestbook-destinationrule.yaml
--------------------
```
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: destination-guestbook
spec:
  host: guestbook
  subsets:
    - name: v1
      labels:
        version: '1.0'
    - name: v2
      labels:
        version: '2.0'
```
virtualservice.yaml
-------------------
```
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
        subset: v2
  - route:
    - destination:
        host: guestbook
        subset: v1
```
```
kubectl apply -f istio-feature-demos/guestbook-app/ab-testing/guestbook-destinationrule.yaml -n istio-demo

kubectl apply -f istio-feature-demos/guestbook-app/ab-testing/virtualservice.yaml -n istio-demo
```

**Step2: Access Ingress gateway Public IP**

You should be able to switch randomly between v1 and v2 versions of guestbook app
http://35.x.x.174
```
kubectl get svc -n istio-system -l istio=ingressgateway
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)  AGE
istio-ingressgateway   LoadBalancer   10.59.246.28   35.x.x.174   15020:30204/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:31399/TCP,15030:32281/TC
P,15031:31950/TCP,15032:31306/TCP,15443:30683/TCP   37h
```