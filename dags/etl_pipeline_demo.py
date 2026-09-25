from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="etl_pipeline",
    default_args=default_args,
    description="Example ETL pipeline DAG for testing Airflow tasks",
    schedule_interval="0 2 * * *",
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=["etl", "test"],
) as dag:

    extract = BashOperator(
        task_id="extract_data",
        bash_command="echo 'Extracting data from source'",
    )

    transform = BashOperator(
        task_id="transform_data",
        bash_command="echo 'Transforming data'",
    )

    load = BashOperator(
        task_id="load_data",
        bash_command="echo 'Loading data to target sink'",
    )

    extract >> transform >> load
