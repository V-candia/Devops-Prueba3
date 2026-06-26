# Frontend Despacho

## Build local

```bash
npm install
npm run build
```

## Variables de entorno

- `VITE_API_VENTAS_URL`: base URL del backend de ventas
- `VITE_API_DESPACHOS_URL`: base URL del backend de despachos

## Build Docker

```bash
docker build \
  --build-arg VITE_API_VENTAS_URL=http://localhost:8081 \
  --build-arg VITE_API_DESPACHOS_URL=http://localhost:8081 \
  -t front-despacho .
```# React + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react/README.md) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh
