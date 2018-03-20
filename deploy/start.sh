#!/bin/bash

PATH=/kingdee/jdk8/bin:$PATH:$HOME/bin:/sbin:/usr/bin:/usr/sbin
APP_NAME="newsCard.rest"
APP_HOME=`cd $(dirname $0)/..;pwd`
CONF_DIR="${APP_HOME}"/config
DIST_JAR=$APP_HOME/jar/main/main.jar
LOG_DIR=/kingdee/rest/${APP_NAME}/logs
PID_FILE="${LOG_DIR}"/"${APP_NAME}".pid
APP_CLASSPATH="$APP_HOME/jar/main/main.jar:$APP_HOME/jar/lib/*"

JAVA_PID=""
if [ -f "${PID_FILE}" ];then
    cd "${APP_HOME}" && sh "bin/shutdown.sh"
fi

# JDK路径
JAVA_HOME=`which java`
JAVA_OPTS="-Dfile.encoding=utf-8 -Xms512M -Xmx512M -Xss1M -XX:MaxPermSize=256M -XX:+UseParallelGC"
JAVA_OPTS="${JAVA_OPTS}"" -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=""${LOG_DIR}"
JAVA_OPTS="${JAVA_OPTS}"" -Dapp.name=""${APP_NAME}"

MAIN_CLASS="com.kingdee.cloudhub.newscard.Application"

#nohup ${JAVA_HOME} ${JAVA_OPTS} -cp $APP_CLASSPATH $MAIN_CLASS --spring.config.location="${CONF_DIR}"/config.yaml >start.log 2>&1 &

nohup ${JAVA_HOME} -jar scregistry-1.0-SNAPSHOT.jar

JAVA_PID=$!

echo "${JAVA_PID}" > "${PID_FILE}"

echo "${APP_NAME}"" start success, pid : ""${JAVA_PID}"
