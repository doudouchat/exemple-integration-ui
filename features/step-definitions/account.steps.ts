import { Before, BeforeAll, Given, Then, When } from '@cucumber/cucumber';
import { expect } from 'chai';


When('create account', (account: string) => {
    console.log(account);
});
