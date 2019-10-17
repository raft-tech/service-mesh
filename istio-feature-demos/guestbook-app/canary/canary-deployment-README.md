# Canary Deployment

The word **Canary** comes from an  old coal mining technique. Coal mines have lot of carbon monoxide and dangerous gases that could kill miners. Canaries are sensitive to air based toxins so miners use them to detect dangerous gases!

With Canary deployments, we could release a new version of the application to a subset of end users (It mostly goes unnoticed, unless its a major release)

New version is incrementally rolled out to users to minimize the risk and impact of any bugs introduced by the newer version

In our case we will send 80% traffic to v1 and 20% traffic to v2

**Step1: Deploy virtual service with 80-20 rule**
virtualservice-80-20.yaml
--------------------
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
            subset: v1
          weight: 80
        - destination:
            host: guestbook
            subset: v2
          weight: 20
```
Apply the YAML manifest for changes to take effect!
```
kubectl apply -f istio-feature-demos/guestbook-app/canary/virtualservice-80-20.yaml -n istio-demo
```

**Step1: Access Ingress gateway Public IP**

80% of the hits will always go to v1 and small percentage(20%) to v2 version of guestbook app
http://35.x.x.174
```
kubectl get svc -n istio-system -l istio=ingressgateway
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)  AGE
istio-ingressgateway   LoadBalancer   10.59.246.28   35.x.x.174   15020:30204/TCP,80:31380/TCP,443:31390/TCP,31400:31400/TCP,15029:31399/TCP,15030:32281/TC
P,15031:31950/TCP,15032:31306/TCP,15443:30683/TCP   37h
```

**This concludes the demo on canary deployment strategy**