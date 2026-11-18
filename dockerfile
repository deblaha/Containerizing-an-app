FROM node:22-alpine AS build
WORKDIR /application
COPY package*.json .
RUN npm ci

FROM gcr.io/distroless/nodejs22
WORKDIR /app
COPY --from=build /application/node_modules node_modules
COPY src src
CMD ["src/hello.js"]