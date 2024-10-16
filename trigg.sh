#!/bin/bash

# Configuration
ORACLE_USER="your_username"
ORACLE_PASS="your_password"
ORACLE_SID="your_sid"
SQL_QUERY="SELECT * FROM table1"
EMAIL_TO="recipient1@example.com,recipient2@example.com"
EMAIL_SUBJECT="Oracle Query Results"
EMAIL_BODY="Please find the attached query results."
ATTACHMENT_NAME="query_results.csv"

# Run Oracle query and save results to a file
sqlplus -S $ORACLE_USER/$ORACLE_PASS@$ORACLE_SID << EOF > $ATTACHMENT_NAME
SET PAGESIZE 0
SET LINESIZE 1000
SET FEEDBACK OFF
SET HEADING ON
SET COLSEP ","
$SQL_QUERY
EXIT;
EOF

# Check if the query was successful
if [ $? -ne 0 ]; then
    echo "Error: Oracle query failed."
    exit 1
fi

# Use Outlook command-line switches to send the email
outlook.exe /c ipm.note /m "${EMAIL_TO}" /subject "${EMAIL_SUBJECT}" /body "${EMAIL_BODY}" /a "${ATTACHMENT_NAME}"

# Check if the email was sent successfully
if [ $? -ne 0 ]; then
    echo "Error: Failed to send email."
    exit 1
fi

echo "Email sent successfully with query results."

# Clean up the temporary file
rm $ATTACHMENT_NAME

exit 0