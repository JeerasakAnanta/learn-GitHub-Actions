# Step 1: Set up the base image
FROM node:18 AS build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json (or yarn.lock)
COPY package.json package-lock.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of your application code
COPY . .

# Step 6: Build the application for production
RUN npm run build

# Step 7: Set up the production image
FROM nginx:alpine

# Step 8: Copy the build output to the nginx html directory
COPY --from=build /app/dist /usr/share/nginx/html

# Step 9: Expose the port that nginx is listening on
EXPOSE 80

# Step 10: Start nginx
CMD ["nginx", "-g", "daemon off;"]