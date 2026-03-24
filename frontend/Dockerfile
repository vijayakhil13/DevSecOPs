FROM node:1.20-alpine AS Build
WORKDIR /app
COPY package.json package-lock.json*
RUN npm ci && cache clean --force
COPY . .
RUN npm run build

FROM nginx:1.27 AS production
RUN rm -rf /etc/nginx/conf.d/default.conf /usr/share/nginx/html/*
COPY src/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/html
RUN chown -R nginx:nginx /usr/share/nginx/html/* && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid 
USER nginx
EXPOSE 80
CMD ["nginx","-g", "daemon off;"]
  
