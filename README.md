# Kubernetes-Learning-Challenge 🧠⚙️

Welcome to the **Kubernetes-Learning-Challenge**!  
This repository is a practical, hands-on guide to learning Kubernetes — one challenge at a time.

Each folder represents a **specific concept**, with a mix of:
- ✅ **Theory and explanation** (`README.md`)
- ⚙️ **Real Kubernetes YAML examples**
- 🧪 **Mini tasks or experiments**

Whether you're a developer, sysadmin, or DevOps engineer — this repo is your playground to **understand and master Kubernetes by doing**.

---

## 🚀 What is Kubernetes?

Kubernetes (also known as **k8s**) is a powerful **container orchestration platform** that helps you:
- Automatically deploy and scale applications
- Recover from failures (self-healing)
- Use **declarative configuration** to manage infrastructure
- Run containers reliably across clusters of machines (cloud or local)

---

## 🧱 Kubernetes Architecture

A Kubernetes cluster typically has:

### 🔹 Control Plane
- `kube-apiserver`: Entry point for all commands (kubectl, REST)
- `etcd`: Cluster data store
- `kube-scheduler`: Decides which node runs a Pod
- `controller-manager`: Reconciles desired vs actual state

### 🔹 Worker Nodes
- `kubelet`: Runs on each node, talks to the API server
- `kube-proxy`: Handles networking and load balancing
- **Container runtime**: Runs containers (e.g., containerd, Docker)
