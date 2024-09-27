FROM sonatype/nexus3

USER root
# Create the directory if it doesn't exist
RUN mkdir -p /nexus-data/etc/
# Change ownership to nexus user and group
RUN chown -R nexus:nexus /nexus-data/etc/

# Switch back to nexus user for running the application
USER nexus

COPY --chown=nexus:nexus keystore.jks /opt/sonatype/sonatype-work/nexus3/etc/ssl/keystore.jks
COPY --chown=nexus:nexus nexus.properties /opt/sonatype/sonatype-work/nexus3/etc
COPY --chown=nexus:nexus jetty-https.xml /opt/sonatype/nexus/etc/jetty