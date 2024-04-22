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
# the following command will copy the build files from the build-stage to the nginx server

COPY --from=build-stage /app/dist /usr/share/nginx/html

# Copy the nginx configuration file
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
# to reache the application from the outside world, we need to expose the port 80
EXPOSE 80
# the following command will start the nginx server
CMD ["nginx", "-g", "daemon off;"]
# 