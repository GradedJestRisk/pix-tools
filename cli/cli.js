#!/usr/bin/node
import chalk from 'chalk';

const callAttention = chalk.bold.red;
const warning = chalk.hex('#FFA500'); // Orange color

require('dotenv').config()
const inquirer = require('inquirer');
const execa = require('execa');
const pgUrlParser = require('pg-connection-string').parse;
const queryString = require('query-string');
const axios = require('axios');

let debugEnabled;

if (process.env.DEBUG === 'yes') {
   debugEnabled = true;
} else {
   debugEnabled = false;
}

// https://developer.atlassian.com/server/jira/platform/jira-rest-api-examples/#searching-for-issues-examples
const statuses = {DOING: 'Doing', UNDER_REVIEW: 'Tech/Func Review', IN_PRODUCTION: 'Deployed in Prod'};
const users = {ME: process.env.JIRA_ACCOUNT_ID, MY_TEAM: process.env.JIRA_USER_TEAM, CROSS_TEAM: 'Cross-Team'}

const queries = {
   crossTeamOpen: `Equipix=${users.CROSS_TEAM} AND status=${statuses.DOING}`,
   myOpenIssues: `assignee=${users.ME} AND status=${statuses.DOING}`,
   myTeamOpenIssues: `Equipix=${users.MY_TEAM} AND status=${statuses.DOING}`,
   myIssuesUnderReview: `assignee=${users.ME} AND status=${statuses.UNDER_REVIEW}`,
   myTeamIssuesUnderReview: `Equipix=${users.MY_TEAM} AND status=${statuses.UNDER_REVIEW}`,
};

const fetchIssues = async (jQLQuery) => {

   const JIRA_API_VERSION = '2';
   const JIRA_API_URL = `https://1024pix.atlassian.net/rest/api/${JIRA_API_VERSION}`;
   const auth = {
      username: process.env.JIRA_ACCOUNT_EMAIL,
      password: process.env.JIRA_ACCOUNT_TOKEN,
   };

   const query = {
      jql: jQLQuery,
      fields: 'key,summary'
   }

   const stringifiedQuery = queryString.stringify(query);
   const url = `${JIRA_API_URL}/search/?${stringifiedQuery}`;

   if (debugEnabled) {
      console.log(`fetching ${stringifiedQuery}...`);
   }

   const response = await axios({method: 'get', url, auth});

   const rawIssues = response.data.issues;
   const issues = rawIssues.map((issue) => {
      return {id: issue.key, title: issue.fields.summary}
   })
   return issues;
}

const fetchPullRequests = async () => {
   const {data} = await axios(`https://api.github.com/repos/1024pix/pix/pulls?q=is%3Apr+is%3Aopen+label%3Ateam-acces`);
   const pullRequests = data;
   return pullRequests;
}

const main = async () => {

   const questions = [
      {
         type: 'rawlist',
         name: 'scope',
         message: 'What do you want ?',
         choices: ['Create a branch', 'Connect to database'],
         default: 'Connect to database'
      }];

   const {choice} = await inquirer.prompt(questions);

   if (choice === 'Create a branch') {
      await createBranch();
   }

   if (choice === 'Connect to database') {
      await connectDatabase();
   }

}

const createBranch = async () => {

   const {scope} = await inquirer.prompt([
      {
         type: 'rawlist',
         name: 'scope',
         message: 'What for ?',
         choices: ['Feature team', 'Captain', 'Cross Team'],
         default: 'Cross Team'
      }]);

   if (scope === 'Cross Team') {

      const issues = await fetchIssues(queries.myTeamOpenIssues);

      if (issues.length === 0) {
         console.error('Open a ticket beforehand');
      } else {

         const {issueTitle} = await inquirer.prompt([
            {
               type: 'rawlist',
               name: 'issueTitle',
               message: 'On which ticket ?',
               choices: issues.map((issue) => {
                  return issue.title
               }),
            }]);

         const selectedIssue = (issues.filter((issue) => {
            return issue.title === issueTitle
         }))[0];

         const {changeBehaviour} = await inquirer.prompt([
            {
               type: 'confirm',
               name: 'changeBehaviour',
               message: 'Will you change external behaviour ?',
               default: true,
            }]);

         if (changeBehaviour === true) {

            const {name} = await inquirer.prompt([
               {
                  type: 'input',
                  name: 'name',
                  message: 'If merged, this branch will.. (complete)',
                  default: selectedIssue.title,
               }]);

            const normalizedName = name.replace(/ /g, "-");
            const branchName = `${selectedIssue.id}-${normalizedName}`.toLowerCase();

            await execa('git', ['checkout', '-b', branchName]);
            console.log(`Branch ${branchName} successfully created !`);
         }


      }
      // console.dir(issues);

   } else {
      console.info('Not implemented!')
   }


}

const connectDatabase = async () => {


   const {scope, tool} = await inquirer.prompt([
      {
         type: 'rawlist',
         name: 'scope',
         message: 'To which environment ?',
         choices: ['Review app', 'Integration', 'QA', 'Production (read only)', 'Production'],
         default: 'Review app'
      },
      {
         type: 'rawlist',
         name: 'tool',
         message: 'With ?',
         choices: ['Web (adminer)', 'console'],
         default: 'console'
      },
   ]);

   if (scope === 'Review app') {
      const pullRequestName = await choosePullRequest();
   }

   if (tool === 'console') {
      let scalingoApplication = {action: 'pgsql-console'}

      if (scope === 'Integration') {
         await execa('scalingo', ['--region', 'osc-secnum-fr1', '--app', 'pix-api-production', 'pgsql-console']);
      }

      if (scope === 'QA') {
         scalingoApplication = {
            name: 'pix-api-recette',
            zone: 'osc-fr1',
         }
      }

      if (scope === 'Production (read only)') {
         scalingoApplication = {
            name: 'pix-datawarehouse-production',
            zone: 'osc-secnum-fr1',
         }
      }

      if (scope === 'Production') {
         scalingoApplication = {
            name: 'pix-api-production',
            zone: 'osc-secnum-fr1',
         }
         console.log(callAttention('This a production environment - and you have write privileges'));
         const {proceed} = await inquirer.prompt([
            {
               type: 'confirm',
               name: 'proceed',
               message: 'Yes, I actually need write access on production',
               default: false,
            }]);

         if (proceed === false) {
            console.log('Bye!')
         }
      }

      if (debugEnabled) {
         console.log(`About to connect to ${scalingoApplication.name} in ${scalingoApplication.zone} using ${scalingoApplication.action}`)
      }
      //await execa('scalingo', ['--region', scalingoApplication.zone, '--app', scalingoApplication.name, scalingoApplication.action]);
   } else {
      console.log('Not implemented yet !')
   }
}

const choosePullRequest = async () => {

   let pullRequestNumber;

   // Replace by fetching PullRequests
   const issueUnderReview = await fetchIssues(queries.myTeamIssuesUnderReview);

   const issueNotInList = 'The issue is not in the list';
   const choices = issueUnderReview.map((issue) => {
      return issue.title
   }).concat(issueNotInList);

   const {issueTitle} = await inquirer.prompt([
      {
         type: 'rawlist',
         name: 'issueTitle',
         message: 'On which ticket ?',
         choices,
      }]);

   if (issueTitle === issueNotInList ) {

      const answers = await inquirer.prompt([
         {
            type: 'input',
            name: 'pullRequestNumber',
            message: "What is the number of your pull request ? (eg. 2872 for https://github.com/1024pix/pix/pull/2872)",
            validate: function (value) {
               const valid = !isNaN(parseFloat(value));
               return valid || 'Please enter a number';
            },
            filter: Number,
         }]);

      pullRequestNumber = answers.pullRequestNumber;

   } else {

      const selectedIssue = (issueUnderReview.filter((issue) => {
         return issue.title === issueTitle
      }))[0];

      pullRequestNumber = selectedIssue.id;
   }

   const reviewAppName = `pix-api-review-pr${pullRequestNumber}`;
   const response = await execa('scalingo', ['env', '--app', reviewAppName]);
   const envVariables = response.stdout.split('\n');

   const credentialKey = 'SCALINGO_POSTGRESQL_URL';
   const credentialsLine = (envVariables.filter(name => name.indexOf(credentialKey + '=') !== -1))[0];

   const credentialUrlPrefix = 'postgres://';
   const credentialsValue = credentialsLine.slice(credentialsLine.indexOf(credentialUrlPrefix));
   const credentials = pgUrlParser(credentialsValue);

   const adminerConfiguration = {
      urlPrefix: 'https://adminer.osc-fr1.scalingo.com/?pgsql=',
      ulrSuffix: '&ns=public'
   }
   const adminerUrl = `${adminerConfiguration.urlPrefix}${credentials.host}:${credentials.port}&username=${credentials.user}&db=${credentials.database}${adminerConfiguration.ulrSuffix}`

   const linkMessage = `Visit ${adminerUrl}`;
   console.log(linkMessage);

   const passwordMessage = `Provide password ${credentials.password}`;
   console.log(passwordMessage);

}

(async () => {

   await main();


   //
   // const pullRequests = await fetchPullRequests();
   // console.log(pullRequests.length + ' pull request fetched');
   // console.dir(pullRequests);


})()
