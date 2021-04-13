FROM node:15.8-alpine3.11
WORKDIR '/app'
COPY package.json .
RUN npm install -g npm@7.6.0
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
