# AWS EKS Expense Management Platform

Production-style DevOps project using:

- Node.js
- Java Spring Boot
- Amazon RDS MySQL
- Docker
- Amazon ECR
- Amazon EKS
- Terraform
- Kubernetes
- AWS Application Load Balancer
- Kubernetes HPA
- GitHub Actions
- Prometheus
- Grafana
- Centralized Logging
- AWS CloudWatch
- AWS Secrets Manager

## Architecture

GitHub
    |
    v
GitHub Actions
    |
    v
Docker
    |
    v
Amazon ECR
    |
    v
Amazon EKS
    |
    +-- Node.js Frontend
    |
    +-- Java Spring Boot Backend
              |
              v
        Amazon RDS MySQL
