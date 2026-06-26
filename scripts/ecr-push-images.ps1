param(
    [Parameter(Mandatory = $true)]
    [string]$AwsRegion,

    [Parameter(Mandatory = $true)]
    [string]$AwsAccountId,

    [string]$VentasRepositoryName = "back-ventas",
    [string]$DespachosRepositoryName = "back-despachos",
    [string]$FrontendRepositoryName = "front-despacho"
)

$ErrorActionPreference = "Stop"

function Write-Section {
    param([string]$Message)
    Write-Host "`n=== $Message ===" -ForegroundColor Cyan
}

function Ensure-Repository {
    param(
        [string]$RepositoryName
    )

    $existing = aws ecr describe-repositories --region $AwsRegion --repository-names $RepositoryName 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Creating ECR repository $RepositoryName..."
        aws ecr create-repository --region $AwsRegion --repository-name $RepositoryName | Out-Null
    }
    else {
        Write-Host "ECR repository $RepositoryName already exists."
    }
}

Write-Section "Checking repositories"
Ensure-Repository -RepositoryName $VentasRepositoryName
Ensure-Repository -RepositoryName $DespachosRepositoryName
Ensure-Repository -RepositoryName $FrontendRepositoryName

Write-Section "Logging in to ECR"
aws ecr get-login-password --region $AwsRegion | docker login --username AWS --password-stdin "$AwsAccountId.dkr.ecr.$AwsRegion.amazonaws.com"

$rootPath = Split-Path -Parent $PSScriptRoot
$ventasPath = Join-Path $rootPath "back-Ventas_SpringBoot\Springboot-API-REST"
$despachosPath = Join-Path $rootPath "back-Despachos_SpringBoot\Springboot-API-REST-DESPACHO"
$frontendPath = Join-Path $rootPath "front_despacho"

$ventasRepoUri = "$AwsAccountId.dkr.ecr.$AwsRegion.amazonaws.com/$VentasRepositoryName"
$despachosRepoUri = "$AwsAccountId.dkr.ecr.$AwsRegion.amazonaws.com/$DespachosRepositoryName"
$frontendRepoUri = "$AwsAccountId.dkr.ecr.$AwsRegion.amazonaws.com/$FrontendRepositoryName"

Write-Section "Building and pushing backend ventas"
docker build -t $VentasRepositoryName:latest $ventasPath
docker tag $VentasRepositoryName:latest "$ventasRepoUri:latest"
docker push "$ventasRepoUri:latest"

Write-Section "Building and pushing backend despachos"
docker build -t $DespachosRepositoryName:latest $despachosPath
docker tag $DespachosRepositoryName:latest "$despachosRepoUri:latest"
docker push "$despachosRepoUri:latest"

Write-Section "Building and pushing frontend"
docker build `
    --build-arg VITE_API_VENTAS_URL="http://localhost:8081" `
    --build-arg VITE_API_DESPACHOS_URL="http://localhost:8081" `
    -t $FrontendRepositoryName:latest `
    $frontendPath
docker tag $FrontendRepositoryName:latest "$frontendRepoUri:latest"
docker push "$frontendRepoUri:latest"

Write-Section "Done"
Write-Host "Pushed images:"
Write-Host "- $ventasRepoUri:latest"
Write-Host "- $despachosRepoUri:latest"
Write-Host "- $frontendRepoUri:latest"