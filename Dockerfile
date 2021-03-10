FROM node:15.8-alpine3.11
WORKDIR '/app'
COPY ./certs/* /etc/ssl/certs/
ENV SSL_CERT_DIR=/etc/ssl/certs
RUN apk add --update --no-cache openssl ca-certificates && update-ca-certificates 
COPY package.json .
RUN npm install -g npm@7.6.0
COPY . .
RUN npm run build

FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html