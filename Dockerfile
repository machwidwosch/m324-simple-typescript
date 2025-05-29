# Schritt 1: Base Image
FROM node:18-alpine AS builder

# Arbeitsverzeichnis im Container
WORKDIR /app

# Abhängigkeiten kopieren und installieren
COPY package.json yarn.lock ./
RUN yarn install

# Source-Code kopieren und kompilieren
COPY . .
RUN yarn build

# Schritt 2: Production-Image
FROM node:18-alpine

WORKDIR /app

# Nur das gebaute Ergebnis + nötige Files kopieren
COPY --from=builder /app/package.json /app/yarn.lock ./
COPY --from=builder /app/build ./build

# Nur production-Abhängigkeiten installieren
RUN yarn install --production

# Startbefehl
CMD ["node", "build/index.js"]
