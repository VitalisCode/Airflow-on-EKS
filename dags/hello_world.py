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
    dag_id="hello_world_demo",
    default_args=default_args,
    description="Simple hello world DAG for validating Airflow on EKS",
    schedule_interval="@daily",
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=["demo", "test"],
) as dag:

    echo_hello = BashOperator(
        task_id="echo_hello",
        bash_command="echo 'Hello from Airflow on EKS'",
    )

    echo_date = BashOperator(
        task_id="echo_date",
        bash_command="date",
    )

    echo_hello >> echo_date
