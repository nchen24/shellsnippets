# Access log in format of 
# 12.34.567.89 - - 98.76.543.21 [12/Mar/4567:12:34:56 +0900] "GET /api/endpoint..."
# Print all timestamps in descending order of # of accesses, grouped by hour
find /usr/local/tomcat/log/AccessLog/ -name "logNamePatternHere" -print0 | sort -z | xargs -0 zcat -f | awk -F "\\[|\\]" '{print $2}' | awk -F ":" '{print $1 ":" $2 ":00:00"}' | uniq -c | sort -nr
