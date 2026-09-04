# azure-gitops-platform
Production-style Azure infrastructure with Terraform, Kubernetes, GitOps (ArgoCD) and monitoring
## Incident Log

### CrashLoopBackOff — Missing serve_forever() call

**Symptom:** After deploying via ArgoCD, the pod entered a
CrashLoopBackOff state, restarting repeatedly.

**Diagnosis:** `kubectl describe pod` showed the container
exiting with code 0 ("Completed") shortly after start —
unusual for a long-running Deployment.

**Root Cause:** The Python HTTP server script created the
server object but never called `server.serve_forever()`,
so the script exited immediately after printing the startup
message.

**Fix:** Added the missing `serve_forever()` call, committed,
and pushed. The CI/CD pipeline (GitHub Actions → ACR → ArgoCD)
automatically built the new image and synced the cluster —
no manual intervention required.

**Lesson:** Exit code 0 doesn't always mean "healthy" in a
Kubernetes context — for long-running services, an unexpected
clean exit is itself the bug.