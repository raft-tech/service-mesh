# Grafana for metrics visualization
**When we install Istio, grafana is installed too**

Grafana is an open source analytics and visualization tool. You can create dashboards within grafana to view your service's performance and other metrics

Grafana allows us to query, visualize, alert on and understand your metrics no matter where they are stored

Grafana gives you the option to create, explore and share dashboards with teams and also customize your dashboards

By default Istio gives you dashboards specific to services, workloads and to view Istio specific components metrics
1. **Istio Pilot Dashboard**
2. **Istio Mesh Dashboard**
3. Istio Mixer Dashboard
4. **Istio Workload Dashboard**
5. Istio Citadel Dashboard
6. Istio Galley Dashboard
7. **Istio Service Dashboard**
8. **Istio Performance Dashboard**

**Step1: Port-forward grafana pod and access it on http://localhost:3000**
```
kubectl -n istio-system port-forward \
    $(kubectl -n istio-system get pod -l app=grafana \
    -o jsonpath={.items[0].metadata.name}) 3000
```

**There is lot to explore with grafana metrics but this should give us a quick headstart into leveraging grafana for metrics**
