Feature: api account

  Background:
    Given delete username 'jean.dupond@gmail.com'
    And get authorization to create account

  Scenario: create account
    When create account
      """
      {
        "optin_mobile": true,
        "birthday": "1967-06-15",
        "firstname": "Jean",
        "addresses": {
          "job": {
            "city": "Paris",
            "street": "rue de la paix"
          },
          "home": {
            "city": "Lyon",
            "street": "rue de la poste"
          }
        },
        "civility": "Mr",
        "mobile": "0610203040",
        "cgus": [
          {
            "code": "code_1",
            "version": "v0"
          }
        ],
        "email": "jean.dupond@gmail.com",
        "lastname": "Dupond"
      }
      """
    And create authorization username 'jean.dupond@gmail.com'
      """
      {
        "password": "mdp"
      }
      """
    And get access for username 'jean.dupond@gmail.com' and password 'mdp'
    Then account is
      """
      {
        "addresses": {
          "home": {
            "street": "rue de la poste",
            "city": "Lyon"
          },
          "job": {
            "street": "rue de la paix",
            "city": "Paris"
          }
        },
        "birthday": "1967-06-15",
        "cgus": [
          {
            "code": "code_1",
            "version": "v0"
          }
        ],
        "civility": "Mr",
        "email": "jean.dupond@gmail.com",
        "firstname": "Jean",
        "lastname": "Dupond",
        "mobile": "0610203040",
        "optin_mobile": true
      }
      """
