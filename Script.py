import pandas as pd
import mysql.connector as m_sql
from sqlalchemy import create_engine as c_engine
from dotenv import load_dotenv
import os

# Load data
df = pd.read_csv("D:\\Data set\\HR_Analytics.csv")

print(df.info())

print(df.isnull().sum())

print(df.describe(include='all'))

# Standardize columns
df.columns = df.columns.str.lower()
print(df.columns)

df = df.dropna(how='any')

# Fill missing values
df["yearswithcurrmanager"] = df.groupby("worklifebalance")[
    'yearswithcurrmanager'].transform(lambda x: x.fillna(x.median()))

print(df["yearswithcurrmanager"].isna().sum())

# load env
load_dotenv()

# connect database
database = m_sql.connect(
    host=os.getenv("MYSQL_HOST"),
    user=os.getenv("MYSQL_USER"),
    passwd=os.getenv("MYSQL_PASSWORD"),
    database=os.getenv("MYSQL_DB")
)

cursor_object = database.cursor()

create_engine = c_engine(
    'mysql+mysqlconnector://root:vivek@localhost/HR_Analytic')


query = "select *from Hr_table"

new_df = pd.DataFrame(df)

new_df.to_sql("Hr_table", create_engine, if_exists='append', index=False)

data = pd.read_sql(query, create_engine)
print(data)

print("query succefully runned!")
# cursor_object.execute(query)
# print("database succefully created:-")
database.close()
