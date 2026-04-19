# ECS Terraform MVP

Resumo rápido
- Projeto: infraestrutura modular em Terraform para criar um cluster ECS (EC2) com ASG, VPC, SG e IAM centralizados.

Pré-requisitos
- Terraform >= 1.5.0
- AWS CLI configurado (credenciais e região `us-east-1`)
- Permissões AWS para criar: VPC, Subnets, EC2, IAM, ECS, Auto Scaling, CloudWatch, S3/DynamoDB (se usar backend remoto)

Estrutura do repositório
- `main.tf`, `providers.tf`, `variables.tf`, `terraform.tfvars` - root
- `modules/` - módulos: `vpc`, `sg`, `cluster`, `asg_ecs_instance`, `iam`
- `CHANGELOG.md` - histórico de alterações e erros resolvidos

Configurar backend remoto (recomendado)
- Use S3 + DynamoDB para state remoto/lock. Exemplo de inicialização:

```bash
terraform init -backend-config="bucket=<your-bucket>" \
  -backend-config="key=ecs/terraform.tfstate" \
  -backend-config="region=us-east-1" \
  -backend-config="dynamodb_table=<your-lock-table>"
```

Como usar
1. Ajuste `terraform.tfvars` (ou crie `terraform.tfvars` a partir do `terraform.tfvars.example`). NÃO comite arquivos com segredos.
2. Inicialize:
```bash
terraform fmt -recursive
terraform init
```
3. Verifique o que será criado:
```bash
terraform plan
```
4. Aplique:
```bash
terraform apply -auto-approve
```

Notas importantes
- Variáveis sensíveis (ex: chaves, profiles) devem ficar fora do repositório. Use variáveis de ambiente ou um backend seguro.
- `terraform.tfvars` frequentemente contém valores específicos do ambiente; ignore em `.gitignore`.
- Para forçar redeploy do serviço ECS sem mudar Terraform:
```bash
aws ecs update-service --cluster <cluster-name> --service <service-name> --force-new-deployment --region us-east-1
```

Publicando no GitHub (passos rápidos)
1. Crie o repositório no GitHub (web UI) ou com o `gh` CLI:
```bash
gh repo create my-ecs-infra --public --source=. --remote=origin
```
2. Commit e push iniciais:
```bash
git init
git add .
git commit -m "Initial Terraform ECS MVP"
git branch -M main
git remote add origin git@github.com:<username>/<repo>.git
git push -u origin main
```

Sugestões de boas práticas
- Proteja a branch `main` com regras de PR e CI.
- Configure workflow de CI (ex.: GitHub Actions) para rodar `terraform fmt` e `terraform validate` em PRs.
- Não coloque `terraform.tfstate` ou `*.tfvars` no repositório.

Referências
- CHANGELOG: `CHANGELOG.md` (histórico de alterações e correções já aplicadas)

Se quiser, posso também:
- Gerar um `workflow` básico para GitHub Actions que valide Terraform em PRs.
- Inicializar o repo remoto e fazer o primeiro push para você (preciso do nome do repo e permissão `gh`/git).
# ECS MVP with Terraform Modules

## Structure

- `providers.tf`: Terraform and AWS provider setup.
- `variables.tf`: Root input variables.
- `main.tf`: Module composition.
- `outputs.tf`: Root outputs.
- `modules/vpc`: VPC, public subnets, route and internet gateway.
- `modules/sg`: Security group for ECS service.
- `modules/cluster`: ECS cluster, task definition and service.

## Quick start

```bash
cd ecs
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

## Notes

- This is a minimal MVP focused on clarity.
- `aws_profile` is optional. Keep it empty in CI environments.
