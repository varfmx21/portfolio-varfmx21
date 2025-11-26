FROM node:20-alpine AS base
WORKDIR /app

COPY package.json package-lock.json ./

FROM base AS build-deps
RUN npm install

FROM build-deps AS build
COPY . .
RUN npm run build

# Usar nginx para servir archivos estáticos
FROM nginx:alpine AS runtime

# Copiar los archivos compilados
COPY --from=build /app/dist /usr/share/nginx/html

# Configuración personalizada de nginx (opcional pero recomendado)
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]