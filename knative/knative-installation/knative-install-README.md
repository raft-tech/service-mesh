# Knative and Istio Installation

Knative is built on top of Istio and Kubernetes

Knative extends Kubernetes to provide a set of middleware components that are essential to build modern, source-centric, and container-based applications that can run anywhere: on premises, in the cloud, or even in a third-party data center

**Knative components**
* Serving - Request driven compute that can scale to zero
* Eventing - Management and Delivery of events

**Installation**

**Install GKE cluster**
Enable APIs
```
gcloud services enable \
  cloudapis.googleapis.com \
  container.googleapis.com \
  containerregistry.googleapis.com
```
Use gcloud to Install GKE
```
gcloud container clusters create knative-demo   --zone=us-east1-b   --cluster-version=latest   --num-nodes=3   --machine-type=n1-standard-2   --enable-autoscaling --min-nodes=1 --max-nodes=5   --enable-autorepair   --scopes=service-control,service-management,compute-rw,storage-ro,cloud-platform,logging-write,monitoring-write,pubsub,datastore
```
Create a ClusterRoleBinding
```
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user=$(gcloud config get-value core/account)
```

**Istio Installation**
Get Latest version of Istio by running this command
```
curl -L https://git.io/getLatestIstio | sh -
```

Navigate to Istio directory (In this example istio-1.3.3)
```
cd istio-1.3.3
```
Check Istio Version and validate install requirements
```
./bin/istioctl version
./bin/istioctl verify-install
```

Install istio
```
kubectl create -f istio-1.3.3/install/kubernetes/istio-demo.yaml
```

**Knative Installation**
```
kubectl apply --selector knative.dev/crd-install=true \
   --filename https://github.com/knative/serving/releases/download/v0.9.0/serving.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.9.0/release.yaml \
   --filename https://github.com/knative/serving/releases/download/v0.9.0/monitoring.yaml
```

```
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.9.0/serving.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.9.0/release.yaml \
   --filename https://github.com/knative/serving/releases/download/v0.9.0/monitoring.yaml
```

Access the pods
```
kubectl get pods --namespace knative-serving
NAME                                READY   STATUS    RESTARTS   AGE
activator-68d9f95cd-zh7pt           2/2     Running   1          6h54m
autoscaler-5655c9fcfd-q4jzr         2/2     Running   1          6h54m
autoscaler-hpa-8668fc6f68-5qf27     1/1     Running   0          6h54m
controller-5b77c5596c-knzhd         1/1     Running   0          6h54m
networking-istio-6d7d44d879-sqr8n   1/1     Running   0          6h54m
webhook-75b4fc9999-br4gq            1/1     Running   0          6h54m


kubectl get pods --namespace knative-eventing
NAME                                  READY   STATUS    RESTARTS   AGE
eventing-controller-db9b58855-ngncm   1/1     Running   0          6h54m
eventing-webhook-595c6b4fd8-wgnmm     1/1     Running   0          6h54m
imc-controller-7b9b7f9f66-j8cr7       1/1     Running   0          6h54m
imc-dispatcher-775c96b5b5-gvxfc       1/1     Running   0          6h54m
sources-controller-78655cd9f9-9qpv4   1/1     Running   0          6h54m

kubectl get pods --namespace knative-monitoring
elasticsearch-logging-0               1/1     Running   0          6h55m
elasticsearch-logging-1               1/1     Running   0          6h53m
fluentd-ds-ggxvx                      1/1     Running   0          6h55m
fluentd-ds-nwwwl                      1/1     Running   0          6h55m
grafana-85c86fb7b9-nb9kh              1/1     Running   0          6h55m
kibana-logging-7cb6b64bff-2njj2       1/1     Running   0          6h55m
kube-state-metrics-74c4cf5565-l8ps8   4/4     Running   0          6h53m
node-exporter-2rxvp                   2/2     Running   0          6h55m
node-exporter-pbk8t                   2/2     Running   0          6h55m
prometheus-system-0                   1/1     Running   0          6h55m
prometheus-system-1                   1/1     Running   0          6h55m
```

Click [here](https://drive.google.com/open?id=16qwcx9i8i96ubh1aQN05D_OVv5rLWdVw) to watch knative install video
**This concludes knative and Istio install on GKE**

