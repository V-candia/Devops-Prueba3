# AWS ECR helper scripts

## Push images to ECR

Use `ecr-push-images.ps1` from PowerShell.

Example:

```powershell
Set-Location "C:\Users\Sepuls Pc's\Downloads\proyecto semestral"
.\scripts\ecr-push-images.ps1 -AwsRegion us-east-1 -AwsAccountId 123456789012
```

The script will:

- create the `back-ventas`, `back-despachos`, and `front-despacho` ECR repositories if they do not exist
- log in to ECR with the AWS CLI
- build the three Docker images
- tag them with the ECR repository URI
- push them to ECR