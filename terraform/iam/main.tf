resource "aws_iam_role" "qa_node_iam_role" {
    name = "qa_node_iam_role"

    assume_role_policy = jsonencode({
        Statement = [{
            Action "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy_attachment" "qa_node_iam_role-AmazonEKSWorkerNodePolicy" {
    policy_arn = var.eks_worker_node_policy
    role = aws_iam_role.qa_node_iam_role.name
}

resource "aws_iam_role_policy_attachment" "qa_node_iam_role-AmazonEKS_CNI_Policy" {
    policy_arn = var.eks_cni_policy
    role = aws_iam_role.qa_node_iam_role.name
}

resource "aws_iam_role_policy_attachment" "qa_node_iam_role-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = var.ec2_container_registry_readonly_policy
    role = aws_iam_role.qa_node_iam_role.name
}

resource "aws_iam_role" "qa_cluster_iam_role" {
    name = "qa_cluster_iam_role"

    assume_role_policy = <<POLICY
{
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "qa_cluster_iam_role-AmazonEKSClusterPolicy" {
    policy_arn = var.eks_cluster_policy
    role = aws_iam_role.qa_cluster_iam_role.name
}

resource "aws_iam_role_policy_attachment" "qa_cluster_iam_role-AmazonEKSServicePolicy" {
    policy_arn = var.eks_service_policy
    role = aws_iam_role.qa_cluster_iam_role.name