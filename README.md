# Nexus Repository with configured HTTPS/SSL 

[NEXUS REPOSITORY](https://hub.docker.com/r/sonatype/nexus3/)


[DOCS](https://help.sonatype.com/en/configuring-ssl.html#inbound-ssl---configuring-to-serve-content-via-https)


[General guide](https://community.jaspersoft.com/knowledgebase/how-to/how-enable-ssl-nexus-3-and-establish-https-connection-jactac/)

run:
docker run -d -p 8081:8081 -p 8443:8443 sonatype/nexus3

[SSL guide from nexus](https://support.sonatype.com/hc/en-us/articles/213465768-SSL-Certificate-Guide?_ga=2.85387033.1024081979.1727010568-378560540.1726553099)
1. SSL certificate:
   keytool -genkeypair -keystore keystore.jks -storepass password -alias example \
   -keyalg RSA -keysize 2048 -validity 5000 -keypass password \
   -dname 'CN=localhost, OU=Sonatype, O=Sonatype, L=Unspecified, ST=Unspecified, C=US' \
   -ext 'SAN=DNS:localhost,IP:192.168.0.0,DNS:www.example.com'
2. 
   IMPORTANT: passwords, alias (example), CN=localhost, SAN=DNS:localhost
   produced keystore.jks is the certificate for java apps, can be converted to other types
3. 
   we need to copy this file to the appropriate directory: /opt/sonatype/sonatype-work/nexus3/etc/ssl
4. [directories of nexus](https://support.sonatype.com/hc/en-us/articles/218707647-How-to-Determine-the-Location-of-the-Nexus-Repository-3-Data-Directory)
   docker cp keystore.jks <container-id>:/opt/sonatype/sonatype-work/nexus3/etc/ssl
   
2. Configure nexus:
   $data-dir/etc/nexus.properties
   docker cp nexus.properties <container-id>:/opt/sonatype/sonatype-work/nexus3/etc
3. Configure Jetty with https (using our certificate)
   Jetty configuration - (SSL server part (lib), part of java code responsible for SSL)
   [stack overflow example of config](https://stackoverflow.com/questions/69763353/how-to-enable-embedded-jetty-9-in-ssl-mode-through-xml-configuration)
   
4. IMPORTANT:
   * certAlias
   * KeyStorePath
   * KeyStorePassword and KeyManagerPassword
   docker cp jetty-https.xml <container-id>:/opt/sonatype/nexus/etc/jetty
   
   To check SSL/HTTPS/needed port
   openssl s_client -connect localhost:8443 -cipher 'ALL'