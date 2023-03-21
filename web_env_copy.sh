#!/bin/sh

help()
{
    ERROR=$1
    echo "$ERROR"
    echo "## Help ############################"
    echo "# web_env_copy.sh <out_file>       #"
    echo "####################################"
}

file=$1

if [ -z $file ]; then
  help "ERROR: File not set"
  exit 1
fi


touch $file

env_vars=$(env | grep '^WEB_ENV')

echo '{' > $file

for var in $env_vars; do
    key=$(echo $var | cut -d '=' -f1)
    value=$(echo $var | cut -d '=' -f2)

    echo "\"$key\":\"$value\"," >> $file
done

sed -i '$ s/,$//' $file

echo '}' >> $file
