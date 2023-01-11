import { AfterAll, BeforeAll, Given } from '@cucumber/cucumber';
import * as cassandra from 'cassandra-driver';
import { AccountContext } from '../step-definitions/account.context';

const client = new cassandra.Client({
    contactPoints: ['127.0.0.1:9042'],
    localDataCenter: 'datacenter1'
});
const axios = require('axios');

BeforeAll(() => {
    axios.interceptors.request.use(request => {
        console.log('Starting Request', JSON.stringify(request, null, 2));
        return request;
    });

    axios.interceptors.response.use(response => {
        return response;
    });
})

AfterAll(async () => {
    await client.shutdown();
})

Given('delete username {string}', async (username: string) => {
    await client.execute('delete from test_authorization.login where username = ?', [username]);
    await client.execute('delete from test_service.login where username = ?', [username]);
});

Given('get authorization to create account', async function (this: AccountContext) {
    const response = await axios.post('http://localhost:8090/ExempleAuthorization/oauth/token',
        new URLSearchParams({ grant_type: 'client_credentials', scope: 'ROLE_APP account:create login:create' }), {
        auth: {
            username: 'test_service',
            password: 'secret'
        }
    });
    this.access_token = response.data.access_token;
    console.log('get authorization ' + response.status + '  token ' + this.access_token);

});

Given('create authorization username {string}', async function (this: AccountContext, username: string, login: string) {
    await axios.put(`http://localhost:8090/ExempleAuthorization/ws/v1/logins/${username}`,
        JSON.parse(login),
        {
            headers: { 'app': 'test', 'Authorization': 'Bearer ' + this.access_token }
        });
});

Given('get access for username {string} and password {string}', async function (this: AccountContext, username: string, password: string) {
    const loginData = new URLSearchParams();
    loginData.append('username', username);
    loginData.append('password', password);
    const loginResponse = await axios.post('http://localhost:8090/ExempleAuthorization/login',
        loginData,
        {
            headers: { 'app': 'test', 'Authorization': 'Bearer ' + this.access_token },
            maxRedirects: 0,
            validateStatus: function (status) {
                return status >= 200 && status < 400;
            }
        });
    const xAuthToken = loginResponse.headers['x-auth-token'];

    const authorizeResponse = await axios.get('http://localhost:8090/ExempleAuthorization/oauth/authorize?response_type=code&client_id=test_service_user&scope=account%3Aread%20login%3Ahead%20login%3Aread',
        {
            headers: { 'x-auth-token': xAuthToken },
            maxRedirects: 0,
            validateStatus: function (status) {
                return status >= 200 && status < 400;
            }
        });

    const location = authorizeResponse.headers['location'];
console.log(location);
    const locationMatcher = /.*code=([a-zA-Z0-9\-_]*)(&state=)?(.*)?/g;
    const matches = locationMatcher.exec(location);
    const code = matches[1];

    const params = {
        grant_type: 'authorization_code',
        code: code,
        client_id: 'test_service_user',
        redirect_uri: 'http://xxx'
    };
    const tokenResponse = await axios.post('http://localhost:8090/ExempleAuthorization/oauth/token',
        new URLSearchParams(params), {
        auth: {
            username: 'test_service_user',
            password: 'secret'
        }
    });
    this.access_token = tokenResponse.data.access_token;
    console.log('get authorization ' + tokenResponse.status + '  token ' + this.access_token);
});
