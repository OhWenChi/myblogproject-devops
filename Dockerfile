# Use an official Python image as base
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy the current project files into the container
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Expose both commonly used ports (staging and production)
EXPOSE 8000
EXPOSE 80

# Set default environment variable for port (can be overridden at runtime)
ENV PORT=8000

# Start the app using the specified PORT (default 8000)
# Replace "main.py" with the actual entry point of your app if different
CMD ["sh", "-c", "python main.py runserver 0.0.0.0:$PORT"]
