# Self-Service, Golden Path for AI/ML and Microservices

Commonly, when we hear of self-service, golden-paths, what comes to mind is GitOps-based approach - a platform for backend. This project has been designed to build self-service platform for ML Engineers and application Developers, alike.
With this in place, ML and app teams will not have to worry about provisioning infrastrcutre; applying their K8s manifests each time it changes; managing desired-state with state-of-the cluster; enforcing policies for K8s-resources, like limits for pods.
This project builds a golden-path for self-service infrastructure, managing both ML/AI jobs and backend services.

## Tools This Setup Uses:
1. `Terraform`: deploys all the infrastrucutre that is common between the AI and Apps (storage, secrets, etc.). Terraform also deploys target-specific resources. For example, `ai-jobs` namespace where the ML batch jobs will be deployed.
2. `ArgoCD`: manages separation of concerns between ML-training jobs and backend or inference services; helps maintain desired-state declaratively. Also, allows for dynamic provisioning of ML jobs and backend-services through `ApplicationSets`.
3. `Kustomize`: overlays target-specific components on base-manifests. For example, for each `Deployment`, Kustomize manages the `image` tag for each different job/service.
4. `Kyverno`: enforces `limits` and `requests` for each pod to ensure that ML jobs don't keep consuming resources.
5. `GitHub Actions`: the orchestrator, which brings it all together. Each job or service lives in its own repo. GitHub Actions workflow run in each repo, builds the  Docker images, and pushes to this repo, where ArgoCD is watching specific paths. 
