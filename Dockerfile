FROM node:18-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM nginx:1.24.0-alpine
COPY --from=build /app/dist usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


