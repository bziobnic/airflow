#!/bin/bash

python3.8 -m venv env
source env/bin/activate
pip install wheel
export AIRFLOW_VERSION=1.10.14
export PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
export CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
# For example: https://raw.githubusercontent.com/apache/airflow/constraints-1.10.14/constraints-3.6.txt
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
# this next line is just to create the default airflow.cfg file
airflow info
sed -i 's/SequentialExecutor$/LocalExecutor/g' ~/airflow/airflow.cfg
su postgres -c <<EOT
"echo \"CREATE DATABASE airflow;
CREATE USER airflow WITH PASSWORD 'airflow';
GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;
\" | psql -f -"
EOT
sed -i 's/sqlite:.*$/postgresql+psycopg2:\/\/airflow:airflow@localhost:5432\/airflow/g' ~/airflow/airflow.cfg

