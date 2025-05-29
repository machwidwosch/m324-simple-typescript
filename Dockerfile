# Schritt 1: Base-Image mit Builder-Label
FROM node:18-alpine AS builder

# Arbeitsverzeichnis
WORKDIR /app

# Dependencies kopieren und installieren
COPY package.json yarn.lock ./
RUN yarn install

# Linting
COPY . .
RUN yarn lint

# Testing
RUN yarn test

# Build
RUN yarn build

# Schritt 2: Production-Image
FROM node:18-alpine

WORKDIR /app

# Nur das Ergebnis und notwendige Dateien kopieren
COPY --from=builder /app/package.json /app/yarn.lock ./
COPY --from=builder /app/build ./build

# Nur production-Abhängigkeiten
RUN yarn install --production

# Startbefehl
CMD ["node", "build/index.js"]
