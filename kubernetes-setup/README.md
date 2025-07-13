# 00 - Kubernetes Setup 🛠️

Welcome! This will help you set up a **local Kubernetes cluster** so you can start running the challenges in this repository.

> **🎯 Goal**: By the end of this challenge, you'll have a running local Kubernetes cluster and understand the basic tools needed for Kubernetes development.

---

## 🎓 What You'll Learn

- Different options for running Kubernetes locally
- How to set up `kind` (Kubernetes in Docker)
- Basic `kubectl` commands to verify your cluster
- Understanding cluster configuration files

---

## ⏱️ Estimated Time
**15-30 minutes** (depending on download speeds)

---

## 📦 Comparing Local Kubernetes Options

| Tool              | Pros                                          | Cons                                             |
|-------------------|-----------------------------------------------|--------------------------------------------------|
| Docker Desktop    | Built-in K8s support, GUI-friendly             | Heavy, not easily scriptable, slower startup     |
| Minikube          | Flexible drivers, close to real clusters       | Slower, VM-based unless using Docker driver      |
| kind (K8s-in-Docker) | Fast, lightweight, scriptable, CI-friendly      | Limited to local dev, not great for multi-node   |

---

## ✅ Why We Use `kind`

We chose [`kind`](https://kind.sigs.k8s.io/) because it is:

- 🐳 Lightweight and uses Docker containers instead of VMs
- ⚡ Extremely fast to start and reset
- 💻 Fully command-line and scriptable (no GUI dependency)
- ♻️ Ideal for isolated, repeatable challenge environments
- 🔁 Perfect for learning and CI/CD testing

---

## 🧰 Tools You’ll Need

| Tool      | Purpose                        |
|-----------|--------------------------------|
| `kubectl` | Command-line interface to K8s  |
| `Docker`  | Required for running `kind`    |
| `kind`    | Runs Kubernetes in Docker      |

---

## 🛠 Step-by-Step Setup

### 1. Install Docker

Install Docker Desktop from: https://www.docker.com/products/docker-desktop  
Ensure it's running before continuing.

---

### 2. Install `kubectl`

Follow the official guide: https://kubernetes.io/docs/tasks/tools/

**Check:**
```bash
kubectl version --client
```
---

### 3. Install `kind`

#### MacOS:
```bash
brew install kind
```
#### Linux:
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```
#### Windows:
download manually from: https://kind.sigs.k8s.io/

---

### 4. Create the Kubernetes Cluster

Run this script:

```bash
./kind-create-cluster.sh
```
✅ This will:

Create a cluster named k8s-learning

Use the kind-cluster-config.yaml file to map ports (for later use with services)

---

### 5. Verify the Cluster Is Running

Run:

```bash
kubectl cluster-info
kubectl get nodes
kubectl get pods -A
```

You should see a control-plane node and several running system pods.

---

## ✅ Validation Checklist

After completing the setup, verify you can:

- [ ] Run `kubectl cluster-info` and see cluster information
- [ ] Run `kubectl get nodes` and see one control-plane node in "Ready" status
- [ ] Run `kubectl get pods -A` and see system pods running
- [ ] Access the cluster context: `kubectl config current-context` shows `kind-k8s-learning`

**Expected Output Examples:**
```bash
# kubectl get nodes
NAME                         STATUS   ROLES           AGE   VERSION
k8s-learning-control-plane   Ready    control-plane   2m    v1.29.0

# kubectl get pods -A (should show system pods like kube-proxy, coredns, etc.)
```

---

## 🧹 Cleanup

When you're done with this challenge or want to start fresh:

```bash
./kind-delete-cluster.sh
```

This completely removes the cluster and frees up resources.

---

## 🎯 What's Next?

Now that you have a working Kubernetes cluster, you're ready for:
- **Challenge 01**: Creating and managing Pods
- Understanding the basic building blocks of Kubernetes applications

---

## 🐛 Troubleshooting

**Cluster creation fails?**
- Ensure Docker is running
- Check if port 8080 is already in use: `lsof -i :8080`
- Try deleting any existing cluster first: `kind delete cluster --name k8s-learning`

**kubectl commands not working?**
- Verify cluster context: `kubectl config get-contexts`
- Switch to correct context: `kubectl config use-context kind-k8s-learning`

**Still having issues?**
- Check kind documentation: https://kind.sigs.k8s.io/docs/user/quick-start/
- Verify Docker has enough resources allocated (4GB+ RAM recommended)