# --- Build ---
FROM node:lts-alpine AS base
WORKDIR /app
COPY package.json package-lock.json ./

FROM base AS prod-deps
RUN npm ci --omit=dev

FROM base AS build-deps
RUN npm ci

FROM build-deps AS build
COPY . .
RUN npm run build

FROM node:lts-alpine AS builder
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=build     /app/dist          ./dist

# --- Runtime - Nginx ---
FROM nginx:alpine AS runtime

RUN apk update && apk upgrade --no-cache

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder --chown=nginx:nginx /app/dist /usr/share/nginx/html

RUN chown -R nginx:nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid

USER nginx

EXPOSE 8080