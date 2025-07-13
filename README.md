# Kubernetes-Learning-Challenge 🧠⚙️

Welcome to the **Kubernetes-Learning-Challenge**!  
This repository is a practical, hands-on guide to learning Kubernetes — one challenge at a time.

Each folder represents a **specific concept**, with a mix of:
- ✅ **Theory and explanation** (`README.md`)
- ⚙️ **Real Kubernetes YAML examples**
- 🧪 **Mini tasks or experiments**

Whether you're a developer, sysadmin, or DevOps engineer — this repo is your playground to **understand and master Kubernetes by doing**.

---

## 📋 Table of Contents

- [What is Kubernetes?](#-what-is-kubernetes)
- [Kubernetes Architecture](#-kubernetes-architecture)
- [Prerequisites](#-prerequisites)
- [Challenge Roadmap](#-challenge-roadmap)
- [Getting Started](#-getting-started)
- [How to Use This Repository](#-how-to-use-this-repository)

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

---

## 📚 Prerequisites

Before starting these challenges, you should have:
- Basic understanding of containers and Docker
- Command line familiarity
- A local development environment with Docker installed
- Basic understanding of YAML syntax

**Recommended but not required:**
- Experience with distributed systems concepts
- Basic networking knowledge
- Familiarity with cloud platforms

---

## 🗺️ Challenge Roadmap

### 🟢 **Beginner Track** - Core Concepts
| Challenge | Topic | Focus | Status |
|-----------|-------|-------|--------|
| 00 | [Kubernetes Setup](./kubernetes-setup/) | Local cluster with kind | ✅ Complete |
| 01 | [Pod Basics](./01-pod-basics/) | Create and run a single Pod | ✅ Complete |
| 02 | Deployments & ReplicaSets | Manage scaling, rolling updates | 🚧 Coming Soon |
| 03 | Services | Expose your app internally & externally | 🚧 Coming Soon |
| 04 | Namespaces | Isolate resources and organize workloads | 🚧 Coming Soon |

### 🟡 **Intermediate Track** - Configuration & Storage
| Challenge | Topic | Focus | Status |
|-----------|-------|-------|--------|
| 05 | ConfigMaps & Secrets | Inject configs and sensitive data | 🚧 Coming Soon |
| 06 | Volumes & Persistent Storage | Store app data reliably | 🚧 Coming Soon |
| 07 | Health Checks | Liveness and readiness probes | 🚧 Coming Soon |
| 08 | Resource Limits | Control CPU/memory usage | 🚧 Coming Soon |

### 🔴 **Advanced Track** - Production & Security
| Challenge | Topic | Focus | Status |
|-----------|-------|-------|--------|
| 09 | Ingress | Route external traffic to services | 🚧 Coming Soon |
| 10 | RBAC | Secure access to cluster resources | 🚧 Coming Soon |
| 11 | Network Policies | Control communication between Pods | 🚧 Coming Soon |
| 12 | Monitoring & Logging | Observability with Prometheus/Grafana | 🚧 Coming Soon |

### 🚀 **Expert Track** - DevOps & Automation
| Challenge | Topic | Focus | Status |
|-----------|-------|-------|--------|
| 13 | Helm | Package and deploy Kubernetes apps | 🚧 Coming Soon |
| 14 | Autoscaling | Scale apps based on load (HPA/VPA) | 🚧 Coming Soon |
| 15 | CI/CD with GitOps | Automate deployment workflows | 🚧 Coming Soon |

---

## 🏁 Getting Started

1. **Clone this repository**
   ```bash
   git clone <your-repo-url>
   cd kubernetes-learning-challenge
   ```

2. **Start with Challenge 00**
   ```bash
   cd kubernetes-setup
   ```

3. **Follow the README in each challenge folder**

---

## 📖 How to Use This Repository

- **Sequential Learning**: Start with Challenge 00 and work your way up
- **Pick & Choose**: Jump to specific topics that interest you
- **Hands-on Practice**: Don't just read - run the commands and experiments
- **Experiment**: Modify the examples and see what happens
- **Clean Up**: Use the provided cleanup scripts between challenges

---
