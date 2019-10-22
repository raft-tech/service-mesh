# Service Mesh

A service mesh is a distributed application infrastructure that is responsible for handling network traffic on behalf of the application in a transparent, out of process manner

**Service mesh consists of control plane and data plane**
* Control plane is the brain of a service mesh
* Data plane has service proxies through which all traffic is handled and observed

**Service Mesh Capabilities**
* Service Resiliency
* Observability
* Traffic management
* Security
* Policy enforcement

# Istio Service Mesh
Istio is a greek word which means **"To Sail"**
* Istio is an open-source implementation of a service mesh founded by Google, IBM, and Lyft
* Istio helps you add resilience and observability to your services architecture in a transparent way
* Istio supports **monolithic** and **microservices** applications
* With Istio, You can manage **network traffic**, **load balance across microservices**, **enforce access policies**, **verify service identity**, **secure service communication** and **observe what exactly is going on with your services**

# Istio Architecture
![Alt text](https://istio.io/docs/concepts/what-is-istio/arch.svg)

# Istio Components
# Control Plane
**Pilot**
* Pilot is a control plane component that allows users and operators to configure service proxies in the data plane
* Pilot takes all higher level istio-configurations specified by the user/operator and convers them into proxy specific configurations for each service proxy that runs as a sidecar
* Pilot exposes APIs for both user/operator and also exposes APIs for data plane

**Citadel**
* Istio uses X.509 certificates to encrypt the traffic from service A to service N
* Citadel handles attestation, issuance/mounting of the certificates and rotation of the certificates

**Mixer**
* Mixer is a key control plane component that handles:
  * Telemetry collection
  * Policy enforcement
  * Quota management/Rate limiting

# Data Plane
**Envoy proxy**
* Envoy is written in c++
* **Envoy is an application proxy that we can insert into the request path of our applications to provide features like:**
  * Service Discovery
  * Load Balancing
  * Traffic/Request routing
  * Traffic Shadowing
  * HTTP/2 and gRPC
  * Network Resiliency(Request-level timeouts, Retries, Circuit breaking)
  * Observability with metrics collection
  * Observability with distributed tracing
  * Automatic TLS termination
  * Rate limiting
  * Health checks

# Why Istio?
* Automatic load balancing for HTTP, gRPC, WebSocket, and TCP traffic
* Fine-grained control of traffic behavior with rich routing rules, retries, failovers, and fault injection.
* A pluggable policy layer and configuration API supporting access controls, rate limits and quotas.
* Automatic metrics, logs, and traces for all traffic within a cluster, including cluster ingress and egress.
* Secure service-to-service communication in a cluster with strong identity-based authentication and authorization
