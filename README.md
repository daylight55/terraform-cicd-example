# Terraform CI/CD Examples

TerraformのCI/CD例をまとめる

## Setup

### Terraformインストール

[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform)

インストール方法は問いません。  
ここでは[mise](https://mise.jdx.dev/getting-started.html) でのインストールを推奨します。インストール方法はリンクを参照してください。

```console
mise use terraform@1.13.5
```

### 推奨: ProviderのCacheディレクトリの指定

通常、TerraformのProviderは `terraform init`を実行したディレクトリ毎の `.terraform` ディレクトリにProvider処理を実行するためのバイナリをダウンロードします。  
個別にダウンロードするとPCのストレージを圧迫するため、ホームディレクトリでCacheディレクトリを指定しておくのがオススメです。

```console
export TF_PLUGIN_CACHE_DIR=$HOME/.terraform.d/plugin-cache
```

### 事前準備: Remote state用のバケットの作成

ローカル環境の認証情報を用いて、バケットを作成します。  
この時点では、ひとまずtfstateはローカル環境で管理します。

例: AWS認証を実行

```console
aws sso login --profile xxx
```

バケットを作成

```console
cd _tfstate
terraform init
terraform apply
```

作成されたバケット名を控えます。

```console
Outputs:

tfstate_bucket_name = "tf-s3-bucket-xxx"
```

ディレクトリを戻る。

```console
cd -
```

### 事前準備: OIDC連携用のIAM Role作成

OIDC連携に用いるIAM Roleを作成します。

backend定義をコンフィグファイルから作成します。

```console
cd _oidc
cp backend.hcl.example backend.hcl
vi backend.hcl

bucket = "<Outputsのtfstate_bucket_nameで控えたバケット名>"
key    = "oidc/terraform.tfstate"
region = "ap-northeast-1"
```

初期設定します。

```console
terraform init -backend-config=backend.hcl
```

`terraform.tfvars`を追加します。

```console
cp terraform.tfvars.example terraform.tfvars
vi terraform.tfvars

repository                    = "<GitHub Actionsでplan/applyをしたいリポジトリ名>" # ex) daylight55/terraform-cicd-example
account_id                    = "<AWSアカウントID。ARNの作成で利用します。>"
aws_terraform_plan_role_name  = "gha-plan"
aws_terraform_apply_role_name = "gha-apply"

```

リソースを作成します。

```console
terraform apply
```

## リソース構築

backend定義をコンフィグファイルから作成します。

```console
cd _oidc
cp backend.hcl.example backend.hcl
vi backend.hcl

bucket = "< Outputsのtfstate_bucket_nameで控えたバケット名 >"
key    = "oidc/terraform.tfstate"
region = "ap-northeast-1"
```

初期設定します。

```console
terraform init -backend-config=backend.hcl
```

TBD。。。GitHub Actions定義をコピーして、お好みのリポジトリで使う方法をまとめる予定。

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.13.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.67 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->