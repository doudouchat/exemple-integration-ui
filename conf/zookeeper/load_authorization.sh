#!/bin/bash

./bin/zkCli.sh create /authorization
./bin/zkCli.sh create /authorization/resource
./bin/zkCli.sh set /authorization/resource '{
	"id": "resource",
	"clientId": "resource",
	"clientSecret": "{bcrypt}$2a$10$FTfSAcT9WVzgHIPqT6dGU.THUVQNReDhMXlB.aq1C8FCPPktD2.Lq",
	"clientAuthenticationMethods": [
		"client_secret_basic"
	],
	"authorizationGrantTypes": [
		"client_credentials"
	],
	"requireAuthorizationConsent": false
}'
./bin/zkCli.sh create /authorization/test_service
./bin/zkCli.sh set /authorization/test_service '{
	"id": "test_service",
	"clientId": "test_service",
	"clientSecret": "{bcrypt}$2a$10$FTfSAcT9WVzgHIPqT6dGU.THUVQNReDhMXlB.aq1C8FCPPktD2.Lq",
	"clientAuthenticationMethods": [
		"client_secret_basic"
	],
	"authorizationGrantTypes": [
		"client_credentials"
	],
	"requireAuthorizationConsent": false,
	"scopes": [
		"account:create",
		"login:head",
		"login:create",
		"subscription:update",
		"subscription:read",
		"ROLE_APP"
	]
}'
./bin/zkCli.sh create /authorization/test_service_user
./bin/zkCli.sh set /authorization/test_service_user '{
	"id": "test_service_user",
	"clientId": "test_service_user",
	"clientSecret": "{bcrypt}$2a$10$FTfSAcT9WVzgHIPqT6dGU.THUVQNReDhMXlB.aq1C8FCPPktD2.Lq",
	"authorizationGrantTypes": [
		"authorization_code",
		"refresh"
	],
	"requireAuthorizationConsent": false,
	"redirectUris": [
		"http://locahost:4200"
	],
	"scopes": [
		"account:read",
		"account:update",
		"login:create",
		"login:update",
		"login:delete",
		"login:read",
		"login:head"
	]
}'
./bin/zkCli.sh create /application
./bin/zkCli.sh create /application/test
./bin/zkCli.sh set /application/test '{
	"keyspace": "test_service",
	"authorization_keyspace": "test_authorization",
	"company": "test_company",
	"authorization_clientIds": [
		"test_service",
		"test_service_user"
	],
	"clientIds": [
		"test_service",
		"test_service_user"
	],
	"account": {
        "uniqueProperties": [ "email" ]
    }
}'