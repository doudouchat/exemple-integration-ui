INSERT INTO test_service.resource_schema (version, resource, profile, content) VALUES (
	'v1',
	'account',
	'user',
	'{
		"$schema": "http://json-schema.org/draft/2020-12/schema",
		"additionalProperties": false,
		"required": [
			"email",
			"lastname",
			"firstname",
			"birthday"
		],
		"dependencies": {
			"optin_mobile": {
				"if": {
					"properties": {
						"optin_mobile": {
							"const": true
						}
					}
				},
				"then": {
					"required": [
						"mobile"
					]
				}
			}
		},
		"properties": {
			"id": {
				"type": "string",
				"readOnly": true
			},
			"email": {
				"type": "string",
				"format": "email"
			},
			"civility": {
				"type": "string",
				"enum": [
					"Mr",
					"Mme"
				]
			},
			"lastname": {
				"type": "string",
				"pattern": "^(?!\\s*$).+"
			},
			"firstname": {
				"type": "string",
				"pattern": "^(?!\\s*$).+"
			},
			"birthday": {
				"type": "string",
				"format": "date"
			},
			"creation_date": {
				"type": "string",
				"format": "date-time",
				"readOnly": true
			},
			"optin_mobile": {
				"type": "boolean"
			},
			"mobile": {
				"type": "string"
			},
			"addresses": {
				"type": "object",
				"maxProperties": 2,
				"additionalProperties": {
					"$ref": "#/definitions/Address"
				}
			},
			"cgus": {
				"type": "array",
				"uniqueItems": true,
				"maxItems": 2,
				"items": {
					"$ref": "#/definitions/Cgu"
				}
			}
		},
		"definitions": {
			"Address": {
				"type": "object",
				"properties": {
					"street": {
						"type": "string",
						"pattern": "^(?!\\s*$).+"
					},
					"city": {
						"type": "string",
						"pattern": "^(?!\\s*$).+"
					}
				},
				"required": [
					"street",
					"city"
				]
			},
			"Cgu": {
				"type": "object",
				"properties": {
					"code": {
						"type": "string",
						"pattern": "^(?!\\s*$).+"
					},
					"version": {
						"type": "string",
						"pattern": "^(?!\\s*$).+"
					}
				},
				"required": [
					"code",
					"version"
				]
			}
		}
	}'
);
