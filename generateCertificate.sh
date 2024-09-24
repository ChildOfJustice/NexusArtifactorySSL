keytool -genkeypair -keystore keystore.jks -storepass password -alias example \
   -keyalg RSA -keysize 2048 -validity 5000 -keypass password \
   -dname 'CN=localhost, OU=Sonatype, O=Sonatype, L=Unspecified, ST=Unspecified, C=US' \
   -ext 'SAN=DNS:localhost,IP:192.168.0.0,DNS:www.example.com'