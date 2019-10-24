# Service Mesh Repository
This repository mainly focuses on the implementation of service mesh on kubernetes platform
Istio is one of the powerful and feature rich open source service mesh option

In this repository following topics are covered:

**Installation and Configuration**
* Managed Kubernetes Installation(GKE) using Terraform
* Minikube(Single node kubernetes cluster) Installation
* Istio Installation on GKE and Minikube

**Application Deployment**

Three different applications are deployed on GKE cluster
* Guestbook application
* Sentiment Analyzer
* Espresso app (coffee product catalog + reviews)
* Java app

**Istio Feature Implementation**

**Traffic Management**
* Routing to a specific version of a service (Example: v1 or v2)
* Blue-Green Deployment
* A/B testing
* Canary Deployment
* User Based Routing
* Traffic Splitting

**Resiliency**
* Timeouts
* Fault Injection
* Circuit breaker

**Security**
* mTLS
* RBAC

**Observability (metrics and tracing)**
* Distributed Tracing using **Jaegar**
* Metrics scraping using **Prometheus**
* Metrics Visualization via dashboards using **Grafana**
* Service Mesh observability using **Kiali** (Istio mesh console)

Click [here](https://drive.google.com/open?id=1CxWiTJwVhDvxQKcSvuQSuL-Qnl5PUK9k) to watch all the demos that cover above mentioned topics
