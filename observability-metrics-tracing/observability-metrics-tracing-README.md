# Observability-Metrics and Tracing
Grafana, Jaegar, Prometheus and Kiali are installed by default when Istio is installed

Managing many microservices gets painful and to know how each microservice is performing is not that easy to find out. We dont have clue as to what exactly is happening with the services that are deployed

Istio's distributed tracing and metrics offers great insight into health of all the services that are deployed. We could get lot of details about each service:
1. Number of requests
2. Performance issues
3. Latency
4. Failures
5. Retries

Istio's control plane called called Istio mixer enabled telemtry within service mesh

**Step1: Lets access grafana dashboard and explore Istio's specific dashboards**
```
kubectl -n istio-system port-forward \
  $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') \
  3000:3000 &
```

![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-1.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-2.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-3.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-4.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-5.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-6.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-7.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-8.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-9.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/grafana-10.png?raw=true)

```
Access http://localhost:3000 and navigate to customized Istio's dashboard; There are plenty of dashboards you could explore

1. Istio Service Dashboard 
2. Istio Service Dashboard
3. Istio Performance Dashboard
4. Istio Pilot Dashboard etc.

In Istio Service dashboard -> Select guestbook-v1 and guestbook-v2 and look at service metrics

Keep accessing the guestbook app and you should see traffic in the dashboard
```


**Step2: Lets look at Jaegar for distributed tracing**
```
kubectl port-forward -n istio-system \
  $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') \
  16686:16686 &
```
```
Access Jaegar via http://localhost:16686
```
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/jaegar-1.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/jaegar-2.png?raw=true)


**Step3: Lets access prometheus and see what metrics prometheus is scraping**
```
kubectl -n istio-system port-forward \
  $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') \
  9090:9090 &
```
```
1. Navigate to http://localhost:9090/graph
2. Under “Expression” input box, enter: istio_request_bytes_count. Click Execute and then select Graph
3. Run another query:
istio_requests_total{destination_service="guestbook.istio-demo.svc.cluster.local", destination_version="1.0"}
istio_requests_total{destination_service="guestbook.istio-demo.svc.cluster.local", destination_version="2.0"}
```
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/prometheus-1.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/prometheus-2.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/prometheus-3.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/prometheus-4.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/prometheus-5.png?raw=true)

**Step4: Access Kiali**
Kiali is an open-source project that installs on top of Istio to visualize your service mesh
```
kubectl -n istio-system port-forward \
$(kubectl -n istio-system get pod -l app=kiali -o jsonpath='{.items[0].metadata.name}') \
20001:20001 &
```
```
Access kiali via http://localhost:20001
```
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-latest-1.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-1.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-2.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-3.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-4.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-5.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-latest-2.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-latest-3.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-latest-4.png?raw=true)
![Alt text](https://github.com/HealthStarInformatics/service-mesh/blob/master/observability-metrics-tracing/images/kiali-latest-5.png?raw=true)

**This concludes obervability portion of Istio**
