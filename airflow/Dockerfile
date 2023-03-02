ARG AIRFLOW_VERSION=2.5.1

FROM apache/airflow:${AIRFLOW_VERSION}

# Install git
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         openjdk-11-jdk \
         git \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
USER ${AIRFLOW_UID}

# Install airflow providers
RUN PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)" && \
    CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt" && \
    pip install --no-cache-dir "apache-airflow[apache.livy,apache.spark,celery,cncf.kubernetes,http,jdbc,papermill,sftp,trino,virtualenv]==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

# Install other packages
RUN pip install --no-cache-dir \
    airflow-code-editor \
    black \
    fs-s3fs
