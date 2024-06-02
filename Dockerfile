# Use the official Node.js image from the Docker Hub
FROM node:14 as noam_image_segev


# Create and change to the app directory
WORKDIR /usr/src/app

# Copy the local code to the container image
COPY app.js .

# Make the container’s port 3000 available to the outside world
EXPOSE 3000

# Run the application
CMD ["node", "app.js"]
