FROM node:16-alpine3.15 as builder

# Force rebuild - updated 2025-11-18
ARG DB_TYPE=sqlite
ENV DB_TYPE=$DB_TYPE

RUN apk add --no-cache python3 py3-pip make gcc g++

COPY . /app

COPY package.json package-lock.json* yarn.lock* /app/

WORKDIR /app

# Use npm install with legacy peer deps to handle React 18 compatibility
RUN npm install --legacy-peer-deps
RUN npm run build:without-migrate

FROM node:16-alpine3.15 as runner

ENV NODE_ENV=production
ARG DB_TYPE=sqlite
ENV DB_TYPE=$DB_TYPE

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY . /app

EXPOSE 3000/tcp

CMD ["npm", "run", "start:with-migrate"]