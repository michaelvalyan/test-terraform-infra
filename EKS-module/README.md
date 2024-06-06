
### README for EKS Cluster Management

This README outlines the steps and considerations for using the provided Terraform script to deploy and manage an Amazon EKS (Elastic Kubernetes Service) cluster. This script automates the provisioning of an EKS cluster, including the necessary AWS resources and Kubernetes configurations.

#### Prerequisites

Before you begin, ensure you have the following prerequisites installed and configured:

- AWS CLI: Make sure you have configured the AWS CLI with appropriate credentials and default region. [AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
- Terraform: This script requires Terraform. [Install Terraform](https://www.terraform.io/downloads.html) if you haven't already.
- kubectl: To interact with your EKS cluster, you'll need `kubectl`. [Install kubectl](https://kubernetes.io/docs/tasks/tools/)

#### Overview

The Terraform script automates the following tasks:

- Fetches the AWS account identity information.
- Configures EKS cluster authentication.
- Sets up a Kubernetes config map (`aws-auth`) for the EKS cluster to manage access.

#### How to Apply the Terraform Script

1. **Initialize Terraform:**
   Run `terraform init` in the directory containing the script. This will initialize the Terraform workspace and download any required providers.

2. **Review the Plan:**
   Execute `terraform plan` to review the resources that will be created or modified. Ensure everything looks correct before proceeding.

3. **Apply the Configuration:**
   Run `terraform apply` to apply the configuration. Confirm the action when prompted. Terraform will provision the EKS cluster and related resources as defined in the script.

4. **Retrieve Cluster Configuration:**
   After the cluster is created, use the AWS CLI to update your `kubeconfig` file with the EKS cluster details. This enables `kubectl` to interact with your cluster:
   ```
   aws eks --region <region-code> update-kubeconfig --name <cluster-name>
   ```

#### Post-Deployment Steps

- **Configure kubectl:**
  Ensure `kubectl` is configured to communicate with your EKS cluster as instructed above. Test the configuration using `kubectl get nodes` to see the worker nodes of your cluster.

- **Deploy Applications:**
  With your EKS cluster up and running, you can now deploy your Kubernetes applications.

- **Monitoring and Management:**
  Consider setting up monitoring and management tools such as Amazon CloudWatch and AWS CloudTrail for your EKS cluster.

#### Cleanup

To delete the resources created by the Terraform script, run `terraform destroy`. Confirm the action when prompted to clean up the resources.

#### Support

For issues or questions regarding the Terraform script or EKS cluster management, refer to the [AWS EKS documentation](https://docs.aws.amazon.com/eks/latest/userguide/) or the [Terraform AWS Provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs).

#### Challenges Encountered

During the creation and management of the EKS cluster using this Terraform script, a couple of challenges were encountered:

- **Worker Nodes Not Joining Cluster:**
  After the initial deployment, the worker nodes did not join the cluster. This issue was resolved by utilizing the `AWSSupport-TroubleshootEKSWorkerNode` runbook from AWS documentation. This runbook analyzes an Amazon EC2 worker node and Amazon EKS cluster to help identify and troubleshoot common causes that prevent worker nodes from joining a cluster, providing guidance to resolve any identified issues.

- **Cycle Dependency Issue with Cross Resource References:**
  The addition of cross-resource references led to a cycle dependency issue. This was addressed by breaking down Terraform resources and specifying parameters associated with the issue outside of original resource, effectively solving the cycle dependency problem.


#### Sources

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon
https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html
https://github.com/antonputra/tutorials/blob/main/lessons/133/terraform/8-iam-oidc.tf
https://github.com/aws-samples/amazon-eks-self-managed-node-group/blob/main/main.tf
https://docs.aws.amazon.com/systems-manager-automation-runbooks/latest/userguide/automation-awssupport-troubleshooteksworkernode.html
https://chat.openai.com/

