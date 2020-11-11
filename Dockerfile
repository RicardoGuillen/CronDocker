FROM ubuntu:20.04
RUN apt-get update && apt-get install -y cron && apt-get install -y default-jre

# Here my script
COPY ejecutaRoboSat.sh /app/
RUN chmod +x /app/ejecutaRoboSat.sh
RUN chmod 0744 /app/ejecutaRoboSat.sh

# Se copia RoboSAT
COPY RoboSat.jar /app/
RUN chmod +x /app/RoboSat.jar


# Cron Config
COPY cronfile /etc/cron.d/cronfile

# Execution Rights 
RUN chmod 0644 /etc/cron.d/cronfile

# Apply cron job
RUN crontab /etc/cron.d/cronfile

# Create the log file ??
RUN touch /var/log/cron.log

# Start cron
CMD cron && tail -f /var/log/cron.log

#CMD ["cron", "-f"]

ENV JAVA_HOME=/usr/bin/java
