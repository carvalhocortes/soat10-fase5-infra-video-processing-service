# 🎬 Infraestrutura do Serviço de Processamento de Vídeos - FIAP SOAT10 Fase 5

Este repositório contém a infraestrutura como código (IaC) usando Terraform para um serviço de processamento de vídeos desenvolvido durante a Fase 5 do curso SOAT da FIAP.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-purple.svg)](https://www.terraform.io/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![AWS EKS](https://img.shields.io/badge/AWS-EKS-FF9900?style=flat&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/eks/)
[![AWS S3](https://img.shields.io/badge/AWS-S3-569A31?style=flat&logo=amazon-s3&logoColor=white)](https://aws.amazon.com/s3/)
[![AWS SQS](https://img.shields.io/badge/AWS-SQS-FF4F8B?style=flat&logo=amazon-sqs&logoColor=white)](https://aws.amazon.com/sqs/)
[![AWS SNS](https://img.shields.io/badge/AWS-SNS-FF9900?style=flat&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/sns/)
[![AWS ECR](https://img.shields.io/badge/AWS-ECR-FF9900?style=flat&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/ecr/)

## 📋 Sobre o Projeto

API de autenticação desenvolvida para a **Quinta Fase da Pós-Graduação em Arquitetura de Software da FIAP - Turma SOAT10**.

Este microserviço é responsável pelo gerenciamento de autenticação e autorização de usuários, implementando um sistema serverless na AWS com foco em **segurança**, **escalabilidade** e **alta disponibilidade**.

### 🎯 Objetivos da Fase 5

- Implementar autenticação segura
- Aplicar padrões de arquitetura serverless
- Demonstrar uso de Infrastructure as Code (IaC) com Terraform
- Aplicar práticas de DevOps e CI/CD

## 📋 Visão Geral

O projeto implementa uma arquitetura completa na AWS para processamento de vídeos, utilizando Kubernetes (EKS) para orquestração de containers e serviços AWS gerenciados para armazenamento e mensageria.

### 🏗️ Arquitetura

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     S3 Bucket   │    │   SNS Topic     │    │   SQS Queue     │
│  Video Storage  │◄──►│   video-files   │───►│  video-files    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │                        │
                                ▼                        ▼
┌─────────────────────────────────────────────────────────────────┐
│                        EKS Cluster                              │
│  ┌─────────────────┐    ┌─────────────────┐                     │
│  │   Node Group    │    │   Load Balancer │                     │
│  └─────────────────┘    └─────────────────┘                     │
└─────────────────────────────────────────────────────────────────┘
```

## 🚀 Recursos Provisionados

### 🔧 Infraestrutura Principal

- **EKS Cluster**: Kubernetes gerenciado na AWS
- **Node Group**: Grupo de nós para execução dos pods
- **VPC**: Rede virtual privada com subnets públicas
- **Security Groups**: Regras de firewall para o cluster

### 📦 Armazenamento e Mensageria

- **S3 Bucket**: Armazenamento de arquivos de vídeo
- **SNS Topic**: Notificações de eventos de vídeo
- **SQS Queue**: Fila para processamento assíncrono
- **ECR Repository**: Registro de imagens Docker

### ⚖️ Balanceamento e Rede

- **Network Load Balancer**: Distribuição de tráfego
- **Kubernetes Service**: Exposição da aplicação

## 🔧 Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configurado
- [kubectl](https://kubernetes.io/docs/tasks/tools/) para gerenciar o cluster
- Conta AWS com permissões administrativas
- [GitHub CLI](https://cli.github.com/) (opcional, para secrets)

## ⚙️ Configuração

### 1. Configurar Backend

Se usar backend remoto, configure no `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "video-processing/terraform.tfstate"
    region = "us-west-2"
  }
}
```

## 🚀 Implantação

### 1. Inicializar Terraform

```bash
terraform init
```

### 2. Planejar a Implantação

```bash
terraform plan
```

### 3. Aplicar a Infraestrutura

```bash
terraform apply -auto-approve
```

### 4. Configurar kubectl

```bash
aws eks update-kubeconfig --region us-west-2 --name eks-fiap-soat10
```

## 📊 Recursos Criados

### S3 Bucket

- **Nome**: `postech-soat10-bucket-video-files`
- **Configurações**:
  - Acesso privado
  - Criptografia AES256
  - Versionamento suspenso
  - Bloqueio de acesso público

### EKS Cluster

- **Nome**: `eks-fiap-soat10`
- **Versão**: Kubernetes mais recente
- **Node Group**: `fiap`
- **Tipo de Instância**: `t3.medium`
- **Scaling**: 1-10 nós

### Mensageria

- **SNS Topic**: `sns-video-files`
- **SQS Queue**: `sqs-video-files`
- **Integração**: SNS → SQS para processamento assíncrono

## 🔐 Segurança

### Security Groups

- Acesso restrito ao cluster EKS
- Portas necessárias abertas conforme configuração

### S3 Security

- Bucket privado com bloqueio de acesso público
- Criptografia server-side habilitada
- Controle de acesso via IAM

## 📤 Saídas (Outputs)

O Terraform exporta as seguintes informações:

```bash
# URLs e ARNs importantes
SQS_VIDEO_FILES_QUEUE_URL     # URL da fila SQS
SNS_VIDEO_FILES_TOPIC_ARN     # ARN do tópico SNS
S3_VIDEO_FILES_BUCKET_NAME    # Nome do bucket S3
S3_VIDEO_FILES_BUCKET_ARN     # ARN do bucket S3
```

## 🔄 CI/CD com GitHub Actions

## 🐳 Deploy da Aplicação

Após a infraestrutura estar pronta:

1. **Build e Push da Imagem**:

   ```bash
   docker build -t your-app .
   docker tag your-app:latest <ECR_URL>/file-processing-api:latest
   docker push <ECR_URL>/file-processing-api:latest
   ```

2. **Deploy no Kubernetes**:
   ```bash
   kubectl apply -f k8s-manifests/
   ```

## 🧹 Limpeza

Para destruir todos os recursos:

```bash
terraform destroy -auto-approve
```

⚠️ **Atenção**: Isso removerá TODOS os recursos, incluindo dados no S3.

## 📚 Documentação Adicional

### Monitoramento

- CloudWatch Logs para EKS
- Métricas de performance do cluster
- Logs de aplicação via kubectl

## 👥 Equipe

### Turma:

SOAT10 - FIAP Pós-Graduação em Arquitetura de Software

### Desenvolvedores:

- Fernando Carvalho de Paula Cortes - rm360486
- Samuel Victor Santos - rm360487

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

**Desenvolvido com ❤️ para a FIAP SOAT10 - Fase 5**
