import pandas as pd

# List of CSV files to be merged
files = ["2023_1.csv", "2023_2.csv", "2023_3.csv", "2023_4.csv", "2023_5.csv", "2023_6.csv",
         "2023_7.csv", "2023_8.csv", "2023_9.csv", "2023_10.csv", "2023_11.csv", "2023_12.csv",
         "2024_1.csv", "2024_2.csv", "2024_3.csv", "2024_4.csv", "2024_5.csv", "2024_6.csv",
         "2024_7.csv", "2024_8.csv", "2024_9.csv", "2024_10.csv", "2024_11.csv", "2024_12.csv"]

# Create an empty DataFrame to store merged data
merged_data = pd.DataFrame()

# Loop through the list of files and read them into DataFrames, then concatenate them vertically
for file in files:
    file_path = file # Update with your actual file path
    df = pd.read_csv(file_path) # Read CSV into DataFrame
    merged_data = pd.concat([merged_data, df], axis=0) # Concatenate DataFrames vertically

# Write merged data to a new CSV file
merged_data.to_csv("merged_data.csv", index=False)
