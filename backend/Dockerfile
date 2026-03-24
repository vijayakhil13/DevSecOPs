FROM node:20-alpine AS build
WORKDIR /app
COPY package.json  .  
#npm install is used because there's no package-lock.json if in case package-lock.json is present then npm ci is used.
RUN npm install --only=production && npm cache clean --force

FROM node:20-alpine AS production
RUN addgroup -S appgroup  && adduser -S appuser -G appgroup
RUN apk --no-cache add dumb-init 
WORKDIR /app
COPY --from=build /app/node_modules /app/node_modules
COPY /src ./src/
RUN chown -R appuser:appgroup /appgroup
USER appuser
EXPOSE 5000
ENTRYPOINT ["dumb-init", "--"]
CMD ["node","src/index.js"]

