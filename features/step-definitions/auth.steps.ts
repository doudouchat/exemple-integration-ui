import { Given, Then, When } from '@cucumber/cucumber';
import * as cassandra from 'cassandra-driver';

const client = new cassandra.Client({
    contactPoints: ['127.0.0.1:9042'],
    localDataCenter: 'datacenter1'
});

Given('delete username {string}', (username: string) => {
    //client.execute('delete from test_authorization.login where username = ?', [username]);
    //client.execute('delete from test_service.login where username = ?', [username]);
});

Given('get authorization to create account', () => {
    console.log('get authorization token');
});
