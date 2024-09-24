# Nexus Repository with configured HTTPS/SSL 

## Resources
[NEXUS REPOSITORY](https://hub.docker.com/r/sonatype/nexus3/)

[SSL guide from nexus](https://support.sonatype.com/hc/en-us/articles/213465768-SSL-Certificate-Guide?_ga=2.85387033.1024081979.1727010568-378560540.1726553099)

[Nexus docs](https://help.sonatype.com/en/configuring-ssl.html#inbound-ssl---configuring-to-serve-content-via-https)

[General guide](https://community.jaspersoft.com/knowledgebase/how-to/how-enable-ssl-nexus-3-and-establish-https-connection-jactac/)

## Deploy
run `deploy.sh`:

1. Generate certificate

   IMPORTANT:
   * passwords
   * alias (example)
   * CN=localhost
   * SAN=DNS:localhost
   
   produced keystore.jks is the certificate for java apps, can be converted to other types

   we need to copy this file to the appropriate directory: /opt/sonatype/sonatype-work/nexus3/etc/ssl
   [directories of nexus](https://support.sonatype.com/hc/en-us/articles/218707647-How-to-Determine-the-Location-of-the-Nexus-Repository-3-Data-Directory)
   
2. Configure nexus: $data-dir/etc/nexus.properties
3. Configure Jetty with https (using our certificate)

   Jetty configuration - (SSL server part (lib), part of java code responsible for SSL)
   [stack overflow example of config](https://stackoverflow.com/questions/69763353/how-to-enable-embedded-jetty-9-in-ssl-mode-through-xml-configuration)
   
   IMPORTANT:
   * certAlias
   * KeyStorePath
   * KeyStorePassword and KeyManagerPassword
   
### Download file using certificate
`curl --cacert example.cert -o test.tgz https://www.example.com:8443/repository/test/testDir/file.tgz`

### To check SSL/HTTPS
   `openssl s_client -connect localhost:8443 -cipher 'ALL'`
   
### Convert jks to other cert formats/keys
```
keytool -exportcert -keystore keystore.jks -alias example -rfc > example.cert
keytool -importkeystore -srckeystore keystore.jks -destkeystore example.p12 -deststoretype PKCS12
openssl pkcs12 -nokeys -in example.p12 -out example.pem

#extract the secret key part:
openssl pkcs12 -nocerts -nodes -in example.p12 -out example.key
```