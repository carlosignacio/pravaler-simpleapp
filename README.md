# simpleapp-python

Bom dia, tudo certo?

Conforme combinado segue em anexo os arquivos da automação para criação do Cluster K8s no GCP via terraform e o arquivo de deployment para subida do POD.

- TUTORIAL:

* Instalar Terraform, gcloud, docker, kubecl e suas dependências.
* Criar conta e projeto no GCP
* Habilitar apis;
   - Kubernetes Engine Api
   - Cloud Resource Manager Api
   - Compute Engine Api
   - Cloud Storage Api
   - Service Networking Api
   - Service Management Api
* Criar Service Account e gerar o Json

Ajustar o path dos módulos e o nome do Json no arquivo "provider.tf".

* Para criar o ambiente, acesse a pasta "pravaler-infra" e execute os comandos abaixo de dentro da pasta terraform:

```sh
cd terraform
```

# Carregar os plugins e estrutura de módulos
```tf
terraform init 
```

# Visualizar sintaxe, acessos e o planejamento da criação dos recursos;
```tf
terraform plan
```

# Criar o ambiente sem necessidade de validação
```tf
terraform apply --auto-approve
```

# Criar o ambiente com necessidade de validação
```tf
terraform apply 
yes
```

# Para executar o deployment
  - Acessar a pasta kubernetes/namespaces
    - Criar namespace
     ```sh
     kubectl create ns pravaler
     ```
     - Executar os Ymls
    ```sh
    kubectl apply -f k8s/ -n pravaler
    ```

# Acessar o ambiente via gcloud
    
     gcloud auth login
     echo "" > ~/.kube/config
     cat ~/.kube/config
     gcloud projects list
     gcloud config set project <PROJECT_ID>
     gcloud container clusters list
     gcloud container clusters get-credentials <CLUSTER_NAME> --zone=<LOCATION>
    