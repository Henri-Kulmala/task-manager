# --- Build stage ---
FROM node:22-alpine AS builder

WORKDIR /app

# Asennetaan riippuvuudet
COPY frontend/package*.json ./
RUN npm install

# Kopioidaan lähdekoodi
COPY frontend/ ./

# VITE API URL build-aikana
ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}

RUN npm run build

# --- Runtime stage (Nginx) ---
FROM nginx:alpine

# Poistetaan oletus nginx-konfigi ja korvataan tarvittaessa omalla (valinnainen)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
