# Proyecto Semestral

Repositorio monorepo con:

- `front_despacho`
- `back-Ventas_SpringBoot/Springboot-API-REST`
- `back-Despachos_SpringBoot/Springboot-API-REST-DESPACHO`
- `scripts`

## Flujo esperado

1. Subir el código a GitHub.
2. Crear los repositorios ECR.
3. Guardar los secretos de GitHub.
4. Ejecutar el workflow `Build and Push Images to ECR`.

## Secretos requeridos en GitHub

- `AWS_REGION`
- `AWS_ACCOUNT_ID`
- `AWS_ROLE_TO_ASSUME`
- `VITE_API_VENTAS_URL`
- `VITE_API_DESPACHOS_URL`

## Repositorios ECR esperados

- `front-despacho`
- `back-ventas`
- `back-despachos`

## Notas

- El frontend se compila con variables de entorno de Vite.
- Los backends se empaquetan desde sus Dockerfiles.
- El deploy a ECS puede hacerse después con otra acción o manualmente desde la task definition.