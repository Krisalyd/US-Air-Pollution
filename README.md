# US-Air-Pollution
This ETL project was made with the purpose of cleaning the data related to the US's Air Pollution.

URL to the original file, with a better description of the file's content:
`https://data.world/data-society/us-air-pollution-data`

I found a few problems with the CSV file provided, making it quite troublesome to work with:
- Many empty values
- Column without a name
- Text Qualifier in random rows. Half of the data has a text qualifier, half doesn't

For the delevopment of this solution I used the following tools:
- Docker
- PostgreSQL
- Apache Airflow

A simple diagram for this solution:
![image](https://user-images.githubusercontent.com/39096217/220820200-0f772d76-3f48-4ac3-ba3d-dcba2a642a4b.png)

