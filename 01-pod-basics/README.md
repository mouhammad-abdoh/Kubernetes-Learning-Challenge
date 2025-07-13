# 01 - Pod Basics 🐳

Welcome to your first real Kubernetes challenge! You'll learn about **Pods** - the smallest deployable unit in Kubernetes.

> **🎯 Goal**: Understand what Pods are, create them, and interact with them using kubectl commands.

---

## 🎓 What You'll Learn

- What Pods are and why they exist
- How to create Pods using YAML manifests
- Essential kubectl commands for Pod management
- Pod lifecycle and states
- How to debug and troubleshoot Pods
- Multi-container Pods (bonus)

---

## ⏱️ Estimated Time
**20-30 minutes**

---

## 🧠 Theory: What is a Pod?

A **Pod** is the smallest deployable unit in Kubernetes. Think of it as a "wrapper" around one or more containers that:

- **Share the same network** (IP address and ports)
- **Share storage volumes** 
- **Are scheduled together** on the same node
- **Live and die together**

### 🤔 Why Pods and not just Containers?

```
🐳 Container = Single process
📦 Pod = Group of tightly coupled containers + shared resources
```

**Real-world analogy**: A Pod is like a "shared apartment" where containers are roommates who share utilities (network, storage) but have their own private spaces.

### 🔄 Pod Lifecycle States

| State | Description |
|-------|-------------|
| `Pending` | Pod accepted but not yet scheduled/started |
| `Running` | Pod scheduled and at least one container is running |
| `Succeeded` | All containers terminated successfully |
| `Failed` | All containers terminated, at least one failed |
| `Unknown` | Pod state cannot be determined |

---

## 🛠️ Hands-On Challenges

### Challenge 1.1: Your First Pod

Let's create a simple Pod running an nginx web server.

**Step 1**: Create the Pod manifest
```bash
# Create the YAML file
cat > simple-pod.yaml << EOF
apiVersion: v1
kind: Pod
metadata:
  name: my-first-pod
  labels:
    app: nginx
    environment: learning
spec:
  containers:
  - name: nginx-container
    image: nginx:1.21
    ports:
    - containerPort: 80
EOF
```

**Step 2**: Deploy the Pod
```bash
kubectl apply -f simple-pod.yaml
```

**Step 3**: Verify it's running
```bash
# Check Pod status
kubectl get pods

# Get more detailed info
kubectl describe pod my-first-pod

# Check Pod logs
kubectl logs my-first-pod
```

**🎯 Expected Output:**
```
NAME           READY   STATUS    RESTARTS   AGE
my-first-pod   1/1     Running   0          30s
```

---

### Challenge 1.2: Interacting with Pods

Now let's interact with our running Pod:

**Access the Pod's shell:**
```bash
kubectl exec -it my-first-pod -- /bin/bash
```

**Inside the Pod, try these commands:**
```bash
# Check the nginx process
ps aux | grep nginx

# Check the Pod's IP address
hostname -i

# Exit the Pod
exit
```

**Port forwarding to access nginx:**
```bash
# Forward local port 8080 to Pod's port 80
kubectl port-forward my-first-pod 8080:80

# In another terminal, test the connection
curl http://localhost:8080
# Or open http://localhost:8080 in your browser
```

---

### Challenge 1.3: Pod with Environment Variables

Let's create a more advanced Pod with environment variables:

```yaml
# Create env-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: env-pod
  labels:
    app: env-demo
spec:
  containers:
  - name: env-container
    image: busybox:1.35
    command: ['sh', '-c']
    args: ['echo "Hello from $MY_NAME in $MY_ENVIRONMENT"; sleep 3600']
    env:
    - name: MY_NAME
      value: "Kubernetes Pod"
    - name: MY_ENVIRONMENT
      value: "Learning Lab"
```

**Deploy and check the logs:**
```bash
kubectl apply -f env-pod.yaml
kubectl logs env-pod
```

**🎯 Expected Output:**
```
Hello from Kubernetes Pod in Learning Lab
```

---

### Challenge 1.4: Multi-Container Pod (Bonus)

Create a Pod with two containers that share the same network:

```yaml
# Create multi-container-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
  containers:
  - name: web-server
    image: nginx:1.21
    ports:
    - containerPort: 80
  - name: log-agent
    image: busybox:1.35
    command: ['sh', '-c']
    args: ['while true; do echo "$(date): Monitoring web-server"; sleep 30; done']
```

**Deploy and explore:**
```bash
kubectl apply -f multi-container-pod.yaml

# Check both containers are running
kubectl get pods

# View logs from specific container
kubectl logs multi-container-pod -c web-server
kubectl logs multi-container-pod -c log-agent

# Access the web-server container
kubectl exec -it multi-container-pod -c web-server -- /bin/bash
```

---

## 🧪 Experiments & Troubleshooting

### Experiment 1: What happens when a Pod fails?

Create a Pod that will fail:

```yaml
# Create failing-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: failing-pod
spec:
  containers:
  - name: failing-container
    image: busybox:1.35
    command: ['sh', '-c', 'exit 1']
```

```bash
kubectl apply -f failing-pod.yaml
kubectl get pods
kubectl describe pod failing-pod
```

**🔍 What do you observe?** The Pod status should show `Error` or `CrashLoopBackOff`.

### Experiment 2: Resource Inspection

```bash
# Get Pod info in different formats
kubectl get pod my-first-pod -o wide
kubectl get pod my-first-pod -o yaml
kubectl get pod my-first-pod -o json

# Watch Pod status in real-time
kubectl get pods -w
```

---

## ✅ Validation Checklist

After completing this challenge, you should be able to:

- [ ] Create a Pod using a YAML manifest
- [ ] Check Pod status with `kubectl get pods`
- [ ] View Pod details with `kubectl describe pod`
- [ ] Access Pod logs with `kubectl logs`
- [ ] Execute commands inside a Pod with `kubectl exec`
- [ ] Use port forwarding to access Pod services
- [ ] Understand Pod lifecycle states
- [ ] Create multi-container Pods

---

## 🧹 Cleanup

Remove all the Pods you created:

```bash
kubectl delete pod my-first-pod
kubectl delete pod env-pod
kubectl delete pod multi-container-pod
kubectl delete pod failing-pod

# Or delete all at once
kubectl delete -f simple-pod.yaml -f env-pod.yaml -f multi-container-pod.yaml -f failing-pod.yaml
```

**Verify cleanup:**
```bash
kubectl get pods
# Should show "No resources found"
```

---

## 🎯 What's Next?

Great job! You now understand the fundamentals of Pods. However, in real-world scenarios, you rarely create Pods directly. Instead, you use higher-level objects like **Deployments** that manage Pods for you.

**Next Challenge**: Challenge 02 - Deployments & ReplicaSets
- Learn why Deployments are better than bare Pods
- Understand scaling and rolling updates
- Manage application lifecycle properly

---

## 🐛 Troubleshooting Guide

**Pod stuck in Pending state?**
- Check if your cluster has enough resources: `kubectl describe pod <pod-name>`
- Look for scheduling errors in the events section

**Pod in CrashLoopBackOff?**
- Check logs: `kubectl logs <pod-name>`
- The container is failing and Kubernetes keeps restarting it

**Can't access Pod via port-forward?**
- Ensure the Pod is in Running state
- Check if the port number is correct
- Verify the container is actually listening on that port

**Exec command not working?**
- Ensure the Pod is running
- Try different shells: `/bin/sh` instead of `/bin/bash`
- Some minimal images don't have bash installed

---

## 📚 Additional Resources

- [Official Pod Documentation](https://kubernetes.io/docs/concepts/workloads/pods/)
- [Pod Lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
