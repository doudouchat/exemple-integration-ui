import { AfterAll, Given } from '@cucumber/cucumber';
import * as cassandra from 'cassandra-driver';
import { AccountContext } from '../step-definitions/account.context';

const client = new cassandra.Client({
    contactPoints: ['127.0.0.1:9042'],
    localDataCenter: 'datacenter1'
});

AfterAll(async () => {
    await client.shutdown();
})

Given('delete username {string}', async (username: string) => {
    await client.execute('delete from test_authorization.login where username = ?', [username]);
    await client.execute('delete from test_service.login where username = ?', [username]);
});

Given('get authorization to create account', async function (this: AccountContext) {
    const axios = require('axios');
    const response = await axios.post('http://localhost:8090/ExempleAuthorization/oauth/token',
        new URLSearchParams({ grant_type: 'client_credentials' }), {
        auth: {
            username: 'test_service',
            password: 'secret'
        }
    });
    this.access_token = response.data.access_token;
    console.log('get authorization ' + response.status + '  token ' + this.access_token);

});

Given('create authorization username {string}', async function (this: AccountContext, username: string, login: string) {
    const axios = require('axios');
    await axios.put(`http://localhost:8090/ExempleAuthorization/ws/v1/logins/${username}`,
        JSON.parse(login),
        { 
            headers: { 'app': 'test', 'Authorization': 'Bearer ' + this.access_token } 
        });
});

Given('get access for username {string} and password {string}', async function (this: AccountContext, username: string, password: string) {
    const axios = require('axios');
    const params = {
        grant_type: 'password',
        username: username,
        password: password,
        client_id: 'test_service_user',
        redirect_uri: 'xxx'
    };

    const response = await axios.post('http://localhost:8090/ExempleAuthorization/oauth/token',
        new URLSearchParams(params), {
        auth: {
            username: 'test_service_user',
            password: 'secret'
        }
    });
    this.access_token = response.data.access_token;
    console.log('get authorization ' + response.status + '  token ' + this.access_token);
});
