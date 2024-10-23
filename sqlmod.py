import re

# Define the list of tables to be replaced and the suffix
tables_to_replace = ["TABLE_1", "TABLE_2", "TABLE_3"]  # Add the table names you want to replace
suffix = "PRODUCT_GXP."

# Define the input and output file paths
input_file_path = 'input.sql'  # Replace with your actual input file path
output_file_path = 'output.sql'  # Replace with your desired output file path

# Read the SQL file
with open(input_file_path, 'r') as file:
    sql_content = file.read()

# Replace each specified table name with its suffixed version, case-insensitively
for table in tables_to_replace:
    # Create a case-insensitive regex pattern for the table name
    pattern = re.compile(re.escape(table), re.IGNORECASE)
    sql_content = pattern.sub(f"{suffix}{table}", sql_content)

# Write the updated content back to the output file
with open(output_file_path, 'w') as file:
    file.write(sql_content)

print(f"Table names have been replaced (case-insensitively) and the updated SQL script is saved to '{output_file_path}'.")