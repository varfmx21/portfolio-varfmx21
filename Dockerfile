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

FROM nginx:alpine AS runtime
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80