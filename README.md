# CowboyElixirHTTPS

Brief example of using HTTPS with Cowboy and Elixir. This application will accept https traffic on localhost:8000 and regular traffic on 8001. 

To run this on your own machine, create your own self-signed ssl key pair in priv/ssl as server.crt and server.key. Be sure to specify the common name as localhost:8000 on your certificate request. 

`$ openssl genrsa -out server.key 2048`

`$ openssl req -new -key server.key -out server.csr`

`$ openssl x509 -req -days 30 -in server.csr  -signkey server.key -out server.crt`


Based on https://github.com/ninenines/cowboy/tree/master/examples/ssl_hello_world
