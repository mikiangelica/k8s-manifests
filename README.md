Hello there

I am Miki.

Welcome to my DevOps Project!

Please refer to the Project Documentation for a walkthrough on the entire process.

The Goal of Project 1 DevOps (Kubernetes) Infrastructure Project is for me to be able to create and understand DevOps processes and technology end to end.


### Notes on Extracted Manifests ###
These manifests are direct exports from my cluster and may include system fields. In a production GitOps workflow, I would clean them using kubectl-net or yq.
### Notes on Secrets ###
Secrets are also exported in raw base64-encoded form for completeness.
In a real production environment, **storing raw secrets in Git is a no-no**
Instead, a team would use Sealed Secrets/External Secrets Operator/HashiCorp Vault/SOPS+GitOps

This repo demonstrates my learning and workflow process. In a prod scenario I would use a proper secret management solution.
