FROM openjdk:8

RUN apt-get update
RUN apt-get install -y postgresql-client

# Set Environment Variables
ENV PDI_VERSION=9.2 PDI_BUILD=9.2.0.0-290 \
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/data-integration \
	KETTLE_HOME=/data-integration

# Aditional Drivers
WORKDIR $KETTLE_HOME    


# Download PDI
RUN wget --progress=dot:giga https://ufpr.dl.sourceforge.net/project/pentaho/Pentaho-9.2/client-tools/pdi-ce-9.2.0.0-290.zip \
	&& unzip -q *.zip \
	&& rm -f *.zip
RUN mkdir /jobs

# COPY ./data-integration /data-integration
# RUN mkdir /jobs


# RUN wget https://downloads.sourceforge.net/project/jtds/jtds/1.3.1/jtds-1.3.1-dist.zip \
# 	&& unzip jtds-1.3.1-dist.zip -d lib/ \
# 	&& rm jtds-1.3.1-dist.zip \
# 	&& wget https://repo.boundlessgeo.com/main/com/oracle/jdbc/ojdbc6/11.1.0.6.0/ojdbc6-11.1.0.6.0.jar \
# 	&& mv ojdbc6-11.1.0.6.0.jar lib/ojdbc6.jar 

RUN wget https://jdbc.postgresql.org/download/postgresql-42.2.5.jar
RUN mv postgresql-42.2.5.jar data-integration/lib/postgresql-42.2.5.jar


# Install xauth
# RUN apt-get update && apt-get install -y xauth


#VOLUME /jobs
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]