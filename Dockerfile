FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

RUN apt-get update && \
    apt-get install -y software-properties-common curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2019.list)"

RUN apt-get update
RUN apt-get install -y mssql-server-is

RUN echo "[TELEMETRY]\nenabled = F" > /var/opt/ssis/ssis.conf

RUN SSIS_PID=Express ACCEPT_EULA=Y /opt/ssis/bin/ssis-conf -n setup

USER mssql

WORKDIR /home/mssql
