# Use the node image from official Docker Hub
FROM node:16.10.0-alpine3.13 as build-stage
# set the working directory
WORKDIR /app
# Copy the working directory in the container
COPY package*.json ./
# Install the project dependencies
RUN npm install
# Copy the rest of the project files to the container
COPY . .
# Build the Vue.js application to the production mode to dist folder
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html