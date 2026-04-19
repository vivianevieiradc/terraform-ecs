# Changelog e Histórico de Alterações

## Estrutura inicial
- Separação em módulos: vpc, sg, cluster, asg_ecs_instance, iam.
- Root com providers, variáveis, main.tf e outputs.

## Ajustes e melhorias
- Criação do módulo `iam` centralizado para roles e policies.
- Módulos `asg_ecs_instance` e `cluster` passaram a receber ARNs/nome das roles via variável.
- Remoção de variáveis e parâmetros não usados (ex: task_cpu, task_memory, subnet_ids, security_group_id do cluster).
- Ajuste do `network_mode` para "host" na task definition.
- Adição da policy SSM para EC2 (acesso via Session Manager).
- Definição explícita de `name` no `aws_autoscaling_group` e ajuste do Launch Template para usar `vpc_security_group_ids`.
- Remoção do bloco `network_configuration` do `aws_ecs_service` para compatibilidade com `network_mode = "host"`.
- Ajuste para uso de VPC customizada (não default).
- Correção de duplicidade do módulo `iam` no main.tf.

## Erros comuns encontrados e soluções
- **IAM Role already exists**: Roles já existentes na conta AWS. Solução: excluir manualmente ou importar para o state do Terraform.
- **ASG GroupName is only supported for EC2-Classic and default VPC**: Causa real foi uso de `security_group_names` no Launch Template. Solução: trocar para `vpc_security_group_ids` (IDs de SG em VPC) e manter `name` explícito no ASG.
- **ECS Service: Network Configuration is not valid for the given networkMode**: Remover bloco `network_configuration` do serviço quando usar `network_mode = "host"` ou "bridge".
- **Module call named "iam" was already defined**: Remover duplicidade do bloco `module "iam"` no main.tf.
- **Missing newline after argument**: Corrigir sintaxe, adicionando quebra de linha ao final do bloco.

## Observações
- Outputs são opcionais, servem para facilitar consultas e integrações.
- Para usar VPC existente, basta passar o ID como variável e ajustar os módulos.
- Para conectar via SSM, a policy AmazonSSMManagedInstanceCore já está anexada às instâncias EC2.

---

Se precisar de mais detalhes ou histórico de outras alterações, só pedir!
