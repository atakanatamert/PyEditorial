FROM python:3.10

WORKDIR /app
COPY . .

# Install requirements
RUN pip install -r requirements.txt

# Make runtime script executable
RUN chmod +x runtime.sh

# Execute commands in runtime, fetching env variables and running gunicorn
CMD ["./runtime.sh"]
