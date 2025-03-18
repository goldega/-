import psycopg2
import pandas as pd

def get_data_from_db():
    conn = psycopg2.connect(
        dbname='booking_db', user='postgres', password='password', host='localhost', port='5432'
    )
    query = "SELECT user_id, weekday, time, daily_load FROM bookings"
    df = pd.read_sql(query, conn)
    conn.close()
    return df
