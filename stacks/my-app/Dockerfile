FROM python:3.12-alpine
WORKDIR /app
COPY app.py ./app.py
ENV PORT=8000 APP_VERSION=v1
EXPOSE 8000
HEALTHCHECK --interval=15s --timeout=5s --retries=3 CMD wget -qO- http://localhost:8000/healthz | grep -q ok
CMD ["python", "app.py"]
