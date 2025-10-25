FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY scripts/test-8000.py /app/test-8000.py
RUN useradd -m appuser
USER appuser
EXPOSE 8000
LABEL org.opencontainers.image.source="https://github.com/do6pbln9l/hh-oauth2-keendns-nginx-systemd"
LABEL org.opencontainers.image.title="HeadHunter OAuth2 Infrastructure — Test Server"
LABEL org.opencontainers.image.description="Minimal HTTP test server for validating nginx/KeenDNS reverse-proxy and OAuth callback path."
CMD ["python", "/app/test-8000.py"]
