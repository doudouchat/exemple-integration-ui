#!/bin/bash

./bin/zkCli.sh create /authorization
./bin/zkCli.sh create /authorization/resource
./bin/zkCli.sh set /authorization/resource '{"client_id":"resource","client_secret":"{bcrypt}$2a$10$I3FyNzNSYN5R5U.4GOWpp.0Np33uJ59p412xzdit798c1jJHCsPja","authorized_grant_types":["client_credentials"],"redirect_uri":[],"autoapprove":[],"authorities":["ROLE_TRUSTED_CLIENT"]}'
./bin/zkCli.sh create /authorization/test_service
./bin/zkCli.sh set /authorization/test_service '{"scope":["account:create","login:head","login:create","subscription:update","subscription:read"],"client_id":"test_service","client_secret":"{bcrypt}$2a$10$FTfSAcT9WVzgHIPqT6dGU.THUVQNReDhMXlB.aq1C8FCPPktD2.Lq","authorized_grant_types":["client_credentials"],"redirect_uri":["xxx"],"autoapprove":["login:create","account:create","subscription:update","subscription:read"],"authorities":["ROLE_APP"],"keyspace":"test_authorization"}'
./bin/zkCli.sh create /authorization/test_service_user
./bin/zkCli.sh set /authorization/test_service_user '{"scope":["account:read","account:update","login:create","login:update","login:delete","login:read","login:head"],"client_id":"test_service_user","client_secret":"{bcrypt}$2a$10$FTfSAcT9WVzgHIPqT6dGU.THUVQNReDhMXlB.aq1C8FCPPktD2.Lq","authorized_grant_types":["password","authorization_code","refresh_token"],"redirect_uri":["xxx"],"autoapprove":["account:read","login:create","login:delete","account:update","login:read","login:update"],"authorities":["ROLE_APP"],"keyspace":"test_authorization"}'
./bin/zkCli.sh create /application
./bin/zkCli.sh create /application/test
./bin/zkCli.sh set /application/test '{"keyspace":"test_service","authorization_keyspace":"test_authorization","company":"test_company","authorization_clientIds":["test_service","test_service_user"],"clientIds":["test_service","test_service_user"]}'
