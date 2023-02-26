// role 
resource "aws_iam_role" "eks-iam-role" {
  name = var.cluster-role

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
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

// attach policy 
resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.name
}

// cluster 
resource "aws_eks_cluster" "eks-cluster" {
  name     = var.eks-cluster 
  role_arn = aws_iam_role.eks-iam-role.arn

  vpc_config {
    subnet_ids = [
     aws_subnet.subnets-private[0].id,
     aws_subnet.subnets-private[1].id,  
     aws_subnet.subnets-public[0].id,
     aws_subnet.subnets-public[1].id

    ]
    // public and private 
    endpoint_private_access = true
    endpoint_public_access  = true 
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
  ]
}

