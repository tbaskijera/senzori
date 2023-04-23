import csv
from random import randint

# Input file name
input_file = "merged_data.csv"  # Replace with the name of your CSV file

# Define a function to generate realistic humidity data for Croatia
def generate_humidity_data(month):
    if month in [4, 5]:  # June, July, August, September - Summer months
        return randint(60, 80)  # Random humidity values between 60 and 80
    elif month in [7,8]:
        return randint(50,70)
    else:  # Other months
        return randint(55, 75)  # Random humidity values between 40 and 70

# Read the input CSV file and replace humidity values
with open(input_file, "r") as file:
    reader = csv.DictReader(file)
    rows = list(reader)
    for row in rows:
        date = row["Date"]
        month_of_date = int(date.split("-")[1])  # Extract month from the date
        row["Humidity"] = generate_humidity_data(month_of_date)  # Replace humidity value

# Write the updated data to a new CSV file
output_file = "merged_data_rl.csv"
with open(output_file, "w", newline="") as file:
    fieldnames = ["Date", "Humidity"]
    writer = csv.DictWriter(file, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)

print(f"Realistic humidity data for Croatia generated and saved to {output_file}.")
