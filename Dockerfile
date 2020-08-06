FROM node:alpine as builder
WORKDIR /var/app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /var/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


#docker build -t vfe-prod .
#docker run -it -p 80:80 vfe-prod