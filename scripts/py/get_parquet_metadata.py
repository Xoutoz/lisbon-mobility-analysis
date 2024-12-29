import pyarrow.parquet as pq

def get_parquet_metadata(file_path):
    parquet_file = pq.ParquetFile(file_path)
    schema = parquet_file.schema_arrow

    column_types = {}
    for field in schema:
        column_types[field.name] = field.type

    return column_types

if __name__ == "__main__":
    file_path = './data/accidents/parquet/ISCTE_2020.parquet'
    metadata = get_parquet_metadata(file_path)
    for column, dtype in metadata.items():
        print(f"Column: {column}, Data Type: {dtype}")