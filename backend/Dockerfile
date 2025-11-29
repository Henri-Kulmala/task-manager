FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./ 
COPY . .

WORKDIR /app/backend

RUN npm install
RUN npm run build

FROM node:22-alpine AS runner

WORKDIR /app/backend

COPY --from=builder /app/backend/dist ./dist
COPY --from=builder /app/backend/node_modules ./node_modules
COPY backend/package*.json ./

ENV NODE_ENV=production
ENV PORT=5000

EXPOSE 5000

CMD ["npm", "start"]
