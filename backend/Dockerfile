
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./


RUN npm install


COPY . .


RUN npm run build


FROM node:22-alpine AS runner

WORKDIR /app


COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./

ENV NODE_ENV=production
ENV PORT=5000

EXPOSE 5000

CMD ["npm", "start"]
