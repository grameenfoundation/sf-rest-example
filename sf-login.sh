#!/bin/bash

# README: for variables to be passed to the parent shell,
# call this script in the following way:
#
# >. ./sf-login.sh
#
# (mind the first dot before calling the script)

SF_USERNAME="username@company.com"
SF_PASSWORD="yourpassword"
SF_TOKEN="your_generated_token"

LOGIN_URL="https://login.salesforce.com/services/Soap/u/25.0"
LOGIN_REQUEST="<?xml version='1.0' encoding='utf-8' ?>
<env:Envelope xmlns:xsd='http://www.w3.org/2001/XMLSchema'
    xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'
    xmlns:env='http://schemas.xmlsoap.org/soap/envelope/'>
    <env:Body>
        <n1:login xmlns:n1='urn:partner.soap.sforce.com'>
            <n1:username>$SF_USERNAME</n1:username>
            <n1:password>$SF_PASSWORD$SF_TOKEN</n1:password>
        </n1:login>
    </env:Body>
</env:Envelope>"

LOGIN_RESPONSE=`echo $LOGIN_REQUEST | curl -s -X POST -H "Content-Type: text/xml; charset=UTF-8" -H "SOAPAction: login" $LOGIN_URL -d @-`

declare -x SESSION_ID=`echo $LOGIN_RESPONSE | sed -e "s/.*<sessionId>\(.*\)<\/sessionId>.*/\1/g"`
declare -x SERVER_URL=`echo $LOGIN_RESPONSE | sed -e "s/.*<serverUrl>\(.*\)<\/serverUrl>.*/\1/g"`
declare -x INSTANCE_NAME=`echo $SERVER_URL | sed -e "s/^https:\/\/\(.*\)\.salesforce\.com.*/\1/g"`