#!/bin/bash
echo "Proccess Start"

while getopts ":hd:" arg; do
  case $arg in
    d) # Specify Deploy Directory.
          DIRECTORY=${OPTARG}
          ;;
  esac
done

cd $DIRECTORY
git pull origin staging

DOCKERCOMMAND="docker exec magento-php-cli magento-command"

$DOCKERCOMMAND ma:e
$DOCKERCOMMAND s:up
$DOCKERCOMMAND s:d:c
$DOCKERCOMMAND s:s:d -f
$DOCKERCOMMAND c:f
$DOCKERCOMMAND ma:d

echo "Finished Process"