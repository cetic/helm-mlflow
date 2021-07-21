FROM python:3.8-slim-buster
RUN apt-get update -y && apt-get install -y build-essential libpq-dev
RUN pip3 install mlflow==1.18.0 psycopg2 boto3
ENV BACKEND_STORE_URI=""
ENV DEFAULT_ARTIFACT_ROOT="/opt/artifact"
EXPOSE 80
CMD mlflow server --host 0.0.0.0 --port 80 --backend-store-uri $BACKEND_STORE_URI --default-artifact-root $DEFAULT_ARTIFACT_ROOT
