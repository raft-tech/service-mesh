# Blue Green Deployments using Istio

Currently we have deployed v1 of the sentiment analyzer application and accessed it via Ingress Gateway public IP
Now we are going to deploy v2 version of the application and allow clients to access it

**V2 version deployment**

**Step1: Deploy v2 version manifest in the same namespace where v1 was deployed**
```
kubectl apply -f istio-feature-demos/blue-green/k8-manifests/sa-frontend-v2-deploy-svc.yaml -n demo
```

**Step2: Create a DestinationRule**
DestinationRule allows us to route traffic to a specific version; we’ll create a DestinationRule that specifies these different versions as subsets
destinationrule-frontend.yaml
-----------------------------
```
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: sa-frontend
spec:
  host: sa-frontend
  trafficPolicy:
    loadBalancer:
      consistentHash:
        httpHeaderName: version
```

**Step3: Access the application**
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
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/istio-feature-demos/blue-green/istio-manifests/traffic-routing/v1-app.png?raw=true)

You should be able to access the application

**Step4: Now edit VirtualService and DestinationRule to send traffic to both versions simultaneously based on weight %**
virtualservice-50-50.yaml
-------------------------
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: sa-external-services
spec:
  hosts:
  - "*"
  gateways:
  - http-gateway
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
        host: sa-frontend
        port:
          number: 80
      weight: 50
    - destination:
        host: sa-frontend-green
        port:
          number: 80
      weight: 50
```
destination-frontend-v1-v2.yaml
-------------------------------
```
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: sa-frontend
spec:
  host: sa-frontend
  subsets:
  - name: sa-frontend-white
    labels:
      version: white
  - name: sa-frontend-green
    labels:
      version: green
```

Apply the manifests
```
kubectl apply -f istio-feature-demos/blue-green/istio-manifests/traffic-routing/virtualservice-50-50.yaml -n demo

kubectl apply -f istio-feature-demos/blue-green/istio-manifests/traffic-routing/destinationrule-frontend-v1-v2.yaml -n demo
```

**Step5: Access the application and keep refreshing the broswer you should see v1 and v2 versions accessible**
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

Keep refreshing the page!
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/istio-feature-demos/blue-green/istio-manifests/traffic-routing/v1-app.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/istio-feature-demos/blue-green/istio-manifests/traffic-routing/v2-app.png?raw=true)

**This concludes leveraging blue-green deployment using Istio**