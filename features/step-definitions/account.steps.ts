import { Then, When } from '@cucumber/cucumber';
import { AccountContext } from '../step-definitions/account.context';

When('create account', { timeout: 10000 }, async function (this: AccountContext, account: string) {
    const axios = require('axios');
    console.log('create account ' + account);
    const response = await axios.post('http://localhost:8080/ExempleService/ws/v1/accounts',
        JSON.parse(account),
        {
            headers: { 'app': 'test', 'version': 'v1', 'Authorization': 'Bearer ' + this.access_token }
        });
    const location = response.headers['location'];
    console.log('create account response' + response.status + ' location ' + location);
    this.id = location.split('/').pop();
});

Then('account is', async function (this: AccountContext, expectedAccount: string) {
    const axios = require('axios');
    const response = await axios.get(`http://localhost:8080/ExempleService/ws/v1/accounts/${this.id}`,
        {
            headers: { 'app': 'test', 'version': 'v1', 'Authorization': 'Bearer ' + this.access_token }
        });
    const account = JSON.stringify(response.data);
    console.log('get account response ' + response.status + ' account ' + account);
});
