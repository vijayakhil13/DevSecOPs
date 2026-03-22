FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json* .
RUN npm ci --only=production && cache clean --force

FROM node:20-alpine AS production
RUN addgroup -S appgroup appuser -S appuser -G appgroup
RUN apk --no-cache add dumb-init 
WORKDIR /app
COPY --from=build /app/node_modules /app/node_modules
COPY /src ./src/
RUN chown -R appuser:appgroup /appgroup
USER appuser
EXPOSE 5000
ENTRYPOINT["dumb-init", "--"]
CMD ["node","src/index.js"]

