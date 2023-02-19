import csv
import airflow
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.postgres_operator import PostgresOperator
from datetime import timedelta

default_args = {
    'owner': 'airflow',
    # 'start_date': datetime(2023, 1, 1),
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag_air_pollution = DAG(dag_id="air_pollution_dag",
                        default_args=default_args,
                        schedule_interval='0 0 * * *',
                        dagrun_timeout=timedelta(minutes=60),
                        description='Load air pollution data',
                        start_date=airflow.utils.dates.days_ago(1)
                        )


def load_pollution_file(**kwargs):
    # Get the csv file path
    csv_file_path = kwargs['params']['csv_file_path']

    # Inicializa o contador
    i = 0

    # Open the csv file
    with open(csv_file_path, 'r') as f:
        reader = csv.DictReader(f)

        for item in reader:
            i += 1

            # Extrai uma linha como dicionário
            current_data = dict(item)

            # Insert data into the PostgreSQL table
            sql_query_data = "INSERT INTO stage.air_pollution_file (%s) VALUES (%s)" % (
                ','.join(current_data.keys()).replace(' ', '_'),
                ','.join(["'" + item + "'" if len(item) != 0 else "'" + 'N/A' + "'" for item in current_data.values()]))

            # Operador do Postgres com incremento no id da tarefa (para cada linha inserida)
            postgres_operator = PostgresOperator(task_id='loading_file_' + str(i),
                                                 sql=sql_query_data,
                                                 params=current_data,
                                                 postgres_conn_id='AirPollutionDW',
                                                 dag=dag_air_pollution)

            # Executa o operador
            postgres_operator.execute(context=kwargs)


load_file = PythonOperator(
    task_id='load_file',
    python_callable=load_pollution_file,
    provide_context=True,
    op_kwargs={'params': {'csv_file_path': '/opt/airflow/dags/air_data/sample_pollution_us_2000_2016.csv'}},
    dag=dag_air_pollution
)

# Upstream
load_file

if __name__ == "__main__":
    dag_air_pollution.cli()
