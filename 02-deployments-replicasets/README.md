# 02 - Deployments & ReplicaSets 🚀

Welcome to Challenge 02! Now that you understand Pods, let's learn about **Deployments** - the production-ready way to manage applications in Kubernetes.

> **🎯 Goal**: Understand why Deployments are better than bare Pods, learn to scale applications, and perform rolling updates safely.

---

## 🎓 What You'll Learn

- Why Deployments are preferred over bare Pods
- How ReplicaSets ensure desired Pod count
- Scaling applications up and down
- Performing rolling updates and rollbacks
- Managing application lifecycle in production
- Deployment strategies and best practices

---

## ⏱️ Estimated Time
**25-35 minutes**

---

## 🧠 Theory: Why Deployments?

In Challenge 01, you created Pods directly. But what happens when:
- A Pod crashes and needs to be restarted?
- You need to run multiple copies for high availability?
- You want to update your application without downtime?

**Bare Pods can't handle these scenarios!** That's where Deployments come in.

### 📦 The Kubernetes Hierarchy

```
🏢 Deployment
    ↓ (manages)
📋 ReplicaSet  
    ↓ (manages)
🐳 Pod(s)
    ↓ (contains)
📦 Container(s)
```

### 🔄 What Each Layer Does

| Component | Purpose |
|-----------|---------|
| **Deployment** | Manages versions, rolling updates, rollbacks |
| **ReplicaSet** | Ensures desired number of Pod replicas are running |
| **Pod** | Runs the actual containers |

### 🆚 Pods vs Deployments

| Aspect | Bare Pods | Deployments |
|--------|-----------|-------------|
| **Self-healing** | ❌ Dies if node fails | ✅ Automatically recreated |
| **Scaling** | ❌ Manual Pod creation | ✅ Simple replica count change |
| **Updates** | ❌ Manual delete/recreate | ✅ Rolling updates with zero downtime |
| **Rollbacks** | ❌ No version history | ✅ Easy rollback to previous versions |
| **Load balancing** | ❌ Single point of failure | ✅ Traffic distributed across replicas |
| **Resource management** | ❌ Manual monitoring | ✅ Automatic resource allocation |
| **Production use** | ❌ Not recommended | ✅ Production ready |
| **Debugging** | ✅ Simple (single Pod) | ⚠️ More complex (multiple moving parts) |

---

## 🛠️ Hands-On Challenges

### Challenge 2.1: Your First Deployment

Let's create a Deployment that manages nginx Pods for us.

**Step 1**: Create the Deployment manifest
```yaml
# Create nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        ports:
        - containerPort: 80
```

**Step 2**: Deploy it
```bash
kubectl apply -f nginx-deployment.yaml
```

**Step 3**: Explore what was created
```bash
# Check the Deployment
kubectl get deployments

# Check the ReplicaSet (created automatically)
kubectl get replicasets

# Check the Pods (created by ReplicaSet)
kubectl get pods

# See everything together
kubectl get all
```

**🎯 Expected Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE
deployment.apps/nginx-deployment   3/3     3         0          30s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-7d8b49ccf7   3         3         3       30s

NAME                                    READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-7d8b49ccf7-abc12   1/1     Running   0          30s
pod/nginx-deployment-7d8b49ccf7-def34   1/1     Running   0          30s
pod/nginx-deployment-7d8b49ccf7-ghi56   1/1     Running   0          30s
```

---

### Challenge 2.2: Understanding Self-Healing

Let's see Kubernetes self-healing in action!

**Delete a Pod and watch it get recreated:**
```bash
# Get current Pods
kubectl get pods

# Delete one Pod (replace with actual Pod name)
kubectl delete pod nginx-deployment-7d8b49ccf7-abc12

# Immediately check - you'll see a new Pod being created
kubectl get pods

# Watch in real-time
kubectl get pods -w
```

**🔍 What do you observe?**
- The deleted Pod is immediately replaced
- Total Pod count stays at 3
- This is the ReplicaSet ensuring desired state!

---

### Challenge 2.3: Scaling Applications

Scaling with Deployments is incredibly easy.

**Scale up to 5 replicas:**
```bash
kubectl scale deployment nginx-deployment --replicas=5

# Check the scaling in action
kubectl get pods
kubectl get deployment
```

**Scale down to 2 replicas:**
```bash
kubectl scale deployment nginx-deployment --replicas=2

# Watch Pods being terminated
kubectl get pods -w
```

**Alternative method - edit the YAML:**
```bash
# Edit the deployment directly
kubectl edit deployment nginx-deployment

# Change the 'replicas: 2' to 'replicas: 4' and save
# Kubernetes immediately applies the change
```

---

### Challenge 2.4: Rolling Updates

Now for the magic - updating your application with zero downtime!

**Update to a new nginx version:**
```bash
# Update the image version
kubectl set image deployment/nginx-deployment nginx=nginx:1.22

# Watch the rolling update happen
kubectl rollout status deployment/nginx-deployment

# See the update strategy in action
kubectl get pods -w
```

**Check the rollout history:**
```bash
kubectl rollout history deployment/nginx-deployment
```

**🔍 What happens during rolling update?**
1. New ReplicaSet is created with new image
2. New Pods are started gradually
3. Old Pods are terminated gradually
4. At no point are all Pods down (zero downtime!)

---

### Challenge 2.5: Rollbacks

Made a mistake? No problem - rollback instantly!

**Simulate a bad deployment:**
```bash
# Deploy a "bad" version (non-existent image)
kubectl set image deployment/nginx-deployment nginx=nginx:broken-tag

# Check the status - it will be stuck
kubectl rollout status deployment/nginx-deployment
kubectl get pods
```

**Rollback to previous version:**
```bash
# Rollback to previous working version
kubectl rollout undo deployment/nginx-deployment

# Check it's working again
kubectl rollout status deployment/nginx-deployment
kubectl get pods
```

**Rollback to specific revision:**
```bash
# See all revisions
kubectl rollout history deployment/nginx-deployment

# Rollback to specific revision (e.g., revision 1)
kubectl rollout undo deployment/nginx-deployment --to-revision=1
```

---

## 🧪 Advanced Experiments

### Experiment 1: Deployment Strategies

Create a deployment with custom rolling update strategy:

```yaml
# Create strategic-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: strategic-deployment
spec:
  replicas: 6
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 2
  selector:
    matchLabels:
      app: strategic-app
  template:
    metadata:
      labels:
        app: strategic-app
    spec:
      containers:
      - name: app
        image: nginx:1.21
        ports:
        - containerPort: 80
```

```bash
kubectl apply -f strategic-deployment.yaml

# Try an update and watch the strategy
kubectl set image deployment/strategic-deployment app=nginx:1.22
kubectl get pods -w
```

### Experiment 2: Detailed Deployment Info

```bash
# Get detailed deployment info
kubectl describe deployment nginx-deployment

# Check ReplicaSet details
kubectl describe replicaset

# See deployment in YAML format
kubectl get deployment nginx-deployment -o yaml
```

### Experiment 3: Resource Management

Let's explore how Deployments handle resource constraints:

```yaml
# Create resource-limited-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: resource-demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: resource-demo
  template:
    metadata:
      labels:
        app: resource-demo
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "100m"
        ports:
        - containerPort: 80
```

```bash
kubectl apply -f resource-limited-deployment.yaml

# Check resource usage
kubectl top pods
kubectl describe deployment resource-demo

# Try scaling beyond cluster capacity
kubectl scale deployment resource-demo --replicas=20
kubectl get pods
kubectl get events --sort-by='.lastTimestamp'
```

**🔍 What happens?** Some Pods may remain in Pending state due to resource constraints.

### Experiment 4: Labels and Selectors

Understanding how Deployments find their Pods:

```bash
# Check current labels on Pods
kubectl get pods --show-labels

# Add a custom label to a Pod
kubectl label pod <pod-name> custom=test

# Try to break the selector relationship
kubectl label pod <pod-name> app=broken --overwrite

# Watch what happens
kubectl get pods --show-labels
kubectl get deployment nginx-deployment -o wide
```

**🔍 What do you observe?**
- The Pod with changed label is "orphaned"
- Deployment creates a new Pod to maintain desired count
- Labels are crucial for Deployment-Pod relationships!

---

## ✅ Validation Checklist

After completing this challenge, you should be able to:

- [ ] Create Deployments using YAML manifests
- [ ] Understand the relationship between Deployments, ReplicaSets, and Pods
- [ ] Scale applications up and down
- [ ] Perform rolling updates with zero downtime
- [ ] Rollback deployments to previous versions
- [ ] Explain why Deployments are better than bare Pods
- [ ] Monitor deployment status and rollout progress
- [ ] Understand the relationship between labels and selectors
- [ ] Handle resource constraints and Pod scheduling issues

---

## 🧹 Cleanup

Remove all the Deployments you created:

```bash
kubectl delete deployment nginx-deployment
kubectl delete deployment strategic-deployment
kubectl delete deployment resource-demo

# Or delete all deployments at once
kubectl delete deployments --all

# Clean up any remaining resources
kubectl delete -f nginx-deployment.yaml -f strategic-deployment.yaml -f resource-limited-deployment.yaml

# Verify cleanup
kubectl get all
# Should show minimal system resources only
```

---

## 🎯 What's Next?

Excellent! You now understand how to manage applications properly in Kubernetes. But how do you access these applications? How do other Pods or external users connect to your Deployments?

**Next Challenge**: Challenge 03 - Services
- Learn how to expose applications
- Understand different Service types
- Connect applications together
- Use the port mapping we configured in kind

---

## 🐛 Troubleshooting Guide

**Deployment stuck in progress?**
```bash
kubectl rollout status deployment/<deployment-name>
kubectl describe deployment <deployment-name>
# Look for events and error messages
```

**Pods not starting?**
```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
# Check for image pull errors or resource constraints
```

**Rolling update not working?**
```bash
kubectl rollout history deployment/<deployment-name>
kubectl describe deployment <deployment-name>
# Check strategy settings and resource availability
```

**ReplicaSet issues?**
```bash
kubectl get replicasets
kubectl describe replicaset <replicaset-name>
# Check selector labels and Pod template
```

**Image pull errors?**
```bash
kubectl get pods
kubectl describe pod <pod-name>
# Look for "ImagePullBackOff" or "ErrImagePull" status
# Check image name and tag spelling
```

**Selector mismatch?**
```bash
kubectl describe deployment <deployment-name>
# Check if selector matches Pod template labels
# Ensure labels are consistent
```

---

## 📚 Key Takeaways

1. **Never use bare Pods in production** - always use Deployments
2. **Deployments provide self-healing** through ReplicaSets
3. **Scaling is as simple** as changing replica count
4. **Rolling updates enable zero-downtime deployments**
5. **Rollbacks are instant** and safe
6. **Kubernetes manages the complexity** of Pod lifecycle for you

## 📋 Quick Command Reference

```bash
# Deployment Management
kubectl create deployment <name> --image=<image>
kubectl apply -f <deployment.yaml>
kubectl get deployments
kubectl describe deployment <name>
kubectl delete deployment <name>

# Scaling
kubectl scale deployment <name> --replicas=<number>
kubectl autoscale deployment <name> --min=2 --max=10 --cpu-percent=80

# Updates & Rollbacks
kubectl set image deployment/<name> <container>=<image>
kubectl rollout status deployment/<name>
kubectl rollout history deployment/<name>
kubectl rollout undo deployment/<name>
kubectl rollout undo deployment/<name> --to-revision=<number>

# Debugging
kubectl get pods -l app=<app-label>
kubectl logs deployment/<name>
kubectl describe rs
```
