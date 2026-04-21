FROM node:20-alpine3.21 AS build
WORKDIR /app
COPY package.json .
RUN npm install && npm cache clean --force
COPY . .
RUN npm run build

FROM nginx:1.27-alpine AS production
RUN rm -rf /etc/nginx/conf.d/default.conf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html/
RUN chown -R nginx:nginx /usr/share/nginx/html/ && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /var/cache/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid 
USER nginx
EXPOSE 8080
CMD ["nginx","-g", "daemon off;"]
  
