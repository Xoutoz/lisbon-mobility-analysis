import pandas as pd
import os


# Directory containing accident files
accidents_dir = "/Users/xoutoz/workspace/master/BDDA/lisbon-mobility-analysis/data/accidents"
target_accidents_dir = "/Users/xoutoz/workspace/master/BDDA/lisbon-mobility-analysis/data/accidents/parquet"
sheet_name = "30 Dias _ Acidentes"

# Iterate over each file in the directory
for filename in os.listdir(accidents_dir):
    if filename.endswith(".xls"):
        file_path = os.path.join(accidents_dir, filename)
        data = pd.read_excel(file_path, sheet_name=sheet_name)

        # Cast all columns to string
        data = data.astype(str)

        # Save the data to a Parquet file
        output_parquet = os.path.join(target_accidents_dir, f"{filename.split('.')[0]}.parquet")
        data.to_parquet(output_parquet)
