FROM sonatype/nexus3

COPY keystore.jks /opt/sonatype/sonatype-work/nexus3/etc/ssl
COPY nexus.properties /opt/sonatype/sonatype-work/nexus3/etc
COPY jetty-https.xml /opt/sonatype/nexus/etc/jetty