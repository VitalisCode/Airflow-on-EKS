from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.python import PythonOperator


def print_message():
    print("Python task is working inside the Airflow on EKS cluster.")


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="python_task_demo",
    default_args=default_args,
    description="Sample Python task DAG",
    schedule_interval="@hourly",
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=["python", "demo"],
) as dag:

    python_task = PythonOperator(
        task_id="print_message",
        python_callable=print_message,
    )

    python_task
