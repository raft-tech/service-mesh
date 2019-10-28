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

Click [here](https://drive.google.com/drive/folders/1Cb-P_1R60sW9IpobwJc9BaZiXCKcdtY2?usp=sharing) to watch microservice application deployment videos

**Istio Feature Implementation**

**Traffic Management**
* Routing to a specific version of a service (Example: v1 or v2)
* Blue-Green Deployment
* A/B testing
* Canary Deployment
* User Based Routing
* Traffic Splitting

Click [here](https://drive.google.com/drive/folders/1lxYlDEkCBaNmWxNAANxdLxlx6fX4UzBt?usp=sharing) to watch traffic management related videos

**Resiliency**
* Timeouts
* Fault Injection
* Circuit breaker

Click [here](https://drive.google.com/drive/folders/1WdLg7p9YteRc5MMEXYd327reT3nmaZU9?usp=sharing) to watch resiliency related videos

**Security**
* mTLS
* RBAC

Click [here](https://drive.google.com/drive/folders/1cbbi0JAkZQBMrroRmufJB5OytGYy83GF?usp=sharing) to watch Istio's security videos

**Observability (metrics and tracing)**
* Distributed Tracing using **Jaegar**
* Metrics scraping using **Prometheus**
* Metrics Visualization via dashboards using **Grafana**
* Service Mesh observability using **Kiali** (Istio mesh console)

Click [here](https://drive.google.com/open?id=1CxWiTJwVhDvxQKcSvuQSuL-Qnl5PUK9k) to watch Istio's observability videos


# Knative

**Installation and Configuration**

Click [here](https://drive.google.com/file/d/16qwcx9i8i96ubh1aQN05D_OVv5rLWdVw/view?usp=sharing) to watch knative installation video on a GKE cluster