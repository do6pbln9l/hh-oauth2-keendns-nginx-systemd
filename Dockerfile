FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY scripts/test-8000.py /app/test-8000.py
RUN useradd -m appuser
USER appuser
EXPOSE 8000
CMD ["python", "/app/test-8000.py"]
