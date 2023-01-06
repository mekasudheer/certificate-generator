# README

To generate SSC we can run below command
rake 'create_certificate[20, "test"]' # first argument is for number of days before it expires and second arg is for domain name.

Once the certificates are generated to run server with created certificates create privatekey.pem and certificate.pem inside certs folder and copy the contents printed in command line or copy them from tmp/certs folder. which will be automatically used by puma server.

Added middleware response to add certificate expiry date to every request of this app. This can be checked inside lib/middlewares.

Added a test case to check and request and response with certificate expiry date.
