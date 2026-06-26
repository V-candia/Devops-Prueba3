const normalizeBaseUrl = (value, fallback) => {
  const baseUrl = value?.trim() || fallback;
  return baseUrl.endsWith("/") ? baseUrl.slice(0, -1) : baseUrl;
};

export const VENTAS_API_BASE_URL = normalizeBaseUrl(
  import.meta.env.VITE_API_VENTAS_URL,
  "http://localhost:8081"
);

export const DESPACHOS_API_BASE_URL = normalizeBaseUrl(
  import.meta.env.VITE_API_DESPACHOS_URL,
  "http://localhost:8081"
);