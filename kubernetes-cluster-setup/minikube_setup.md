# Minikube Installation
Minikube is a single node Kubernetes Cluster solution which runs locally on your laptop

Very useful for developers/administrators to test their work locally

# Prerequisites
*Docker is needed prior to Minikube install*
https://www.docker.com/products/docker-desktop
Download Docker-Desktop for MAC

# Steps to Install Minikube on Windows
**Step1: Install Kubectl command line utility**

```
https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-windows
```

**Step2: Make sure you have VirtualBox and Chocolatey installed on your laptop**

```
https://www.virtualbox.org/wiki/Downloads
```
```
https://chocolatey.org/
```

**Step3: Install Minikube via Chocolatey**

```
choco install minikube kubernetes-cli
```

**Step4: Install Minikube using the executable**
**Download and Install the executable**

```
https://github.com/kubernetes/minikube/releases/latest/download/minikube-installer.exe
```

**Step5: To start minikube after installation**

```
minikube start
```

**Step6: To check status of minikube**

```
minikube status
```

**Step7: To get minikube cluster IP address**

```
minikube ip
```

**Step8: To delete minikube cluster**
```
minikube delete
```

**Step9: To access kubernetes dashboard**
```
minikube dashboard
```


# Steps to Install minikube on MAC
**Step1: Install minikube and kubectl using Homebrew**

```
brew cask install minikube kubernetes-cli
```

**Step2: To start minikube after installation**

```
minikube start
```

**Step3: To check status of minikube**

```
minikube status
```

**Step4: To get minikube cluster IP address**

```
minikube ip
```

**Step5: To access kubernetes dashboard**
```
minikube dashboard
```

**Step6: To delete minikube cluster**
```
minikube delete
```

**Step7: To get minikube cluster info**
```
kubectl cluster-info
```

**Step8: To get minikube single cluster node**
```
kubectl get nodes
```
