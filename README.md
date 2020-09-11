# Lighthouse Check Orb

> A CircleCI Orb for running Lighthouse audits automatically in a workflow with a rich set of extra features. Simple implementation or advanced customization including **Slack** notifications, **AWS S3** HTML report uploads, and more!

This project provides **two ways of running audits** - "locally" by default in a dockerized environment or remotely via [Foo's Automated Lighthouse Check](https://www.foo.software/lighthouse) API. For basic usage, running locally will suffice, but if you'd like to maintain a historical record of Lighthouse audits and utilize other features, you can follow the [steps and examples](#usage-foo-api).

<table>
  <tr>
    <td>
      <img alt="Lighthouse" src="https://lighthouse-check.s3.amazonaws.com/images/lighthouse-600x600.png" width="400" />
    </td>
    <td>
      <img alt="AWS S3" src="https://lighthouse-check.s3.amazonaws.com/images/github-actions/aws-s3-logo.png" />
    </td>
    <td>
      <img alt="Slack" src="https://lighthouse-check.s3.amazonaws.com/images/github-actions/slack-logo.png" />
    </td>
  </tr>
</table>

## How this Project Differs from Others

Simple configuration or choose from a variety of features below. See the [example Lighthouse Check Orb implementation](#example-usage).

- 💛 Lighthouse audit **multiple** URLs or just one.
- 💛 Save a record of all your audits via [Foo's Automated Lighthouse Check](#usage-foo-api).
- 💗 Save HTML reports locally.
- 💚 Upload HTML reports as artifacts.
- 💙 Upload HTML reports to AWS S3.
- ❤️ Fail a workflow when minimum scores aren't met. [Example at the bottom](#user-content-example-usage-failing-workflows-by-enforcing-minimum-scores).
- 💜 **Slack** notifications.
- 💖 Slack notifications **with Git info** (author, branch, PR, etc).

# Table of Contents

- [Screenshots](#screenshots)
  - [Output](#screenshot-output)
  - [Save HTML Reports as Artifacts](#screenshot-save-html-reports-as-artifacts)
  - [HTML Reports](#screenshot-html-reports)
  - [Slack Notifications](#screenshot-slack-notifications)
  - [Fail Workflow when Minimum Scores Aren't Met](#screenshot-fail-workflow-when-minimum-scores-arent-met)
- [Parameters](#parameters)
- [Usage](#usage)
  - [Standard Example](#usage-standard-example)
  - [Failing Workflows by Enforcing Minimum Scores](#usage-failing-workflows-by-enforcing-minimum-scores)
  - [Foo API](#usage-foo-api)

# Screenshots

A visual look at the things you can do.

## Screenshot: Output
<img alt="Lighthouse Check Orb output" src="https://lighthouse-check.s3.amazonaws.com/images/circleci/circleci-orb-lighthouse-check-output.png" />

## Screenshot: Save HTML Reports as Artifacts
<img alt="Lighthouse Check Orb save artifacts" src="https://lighthouse-check.s3.amazonaws.com/images/circleci/circleci-orb-lighthouse-check-artifacts.png" />

## Screenshot: HTML Reports
<img alt="Lighthouse Check Orb HTML report" src="https://lighthouse-check.s3.amazonaws.com/images/circleci/circleci-orb-lighthouse-check-report.png" />

## Screenshot: Slack Notifications
<img alt="Lighthouse Check Orb Slack notification" src="https://lighthouse-check.s3.amazonaws.com/images/circleci/circleci-orb-lighthouse-check-slack.png" width="600" />

## Screenshot: Fail Workflow when Minimum Scores Aren't Met

<img alt="Lighthouse Check Orb fail if scores don't meet minimum requirement on a PR" src="https://lighthouse-check.s3.amazonaws.com/images/circleci/circleci-orb-lighthouse-check-fail.png" />

## Parameters

You can choose from two ways of running audits - "locally" in a dockerized environment (by default) or remotely via the [Foo's Automated Lighthouse Check](https://www.foo.software/lighthouse) API. For directions about how to run remotely see the [Foo API Usage](#usage-foo-api) section. We denote which options are available to a run type with the `Run Type` values of either `local`, `remote`, or `both` respectively.

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Run Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>apiToken</code></td>
    <td>The foo.software account API token found in the dashboard.</td>
    <td><code>string</code></td>
    <td><code>remote</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>author</code></td>
    <td>For Slack notifications: A user handle, typically from GitHub.</td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>$CIRCLE_USERNAME</code></td>
  </tr>
  <tr>
    <td><code>awsAccessKeyId</code></td>
    <td>The AWS <code>accessKeyId</code> for an S3 bucket.</td>
    <td><code>string</code></td>
    <td><code>local</code></td>
    <td><code>$LIGHTHOUSE_CHECK_AWS_ACCESS_KEY_ID</code></td>
  </tr>
  <tr>
    <td><code>awsBucket</code></td>
    <td>The AWS <code>Bucket</code> for an S3 bucket.</td>
    <td><code>string</code></td>
    <td><code>local</code></td>
    <td><code>$LIGHTHOUSE_CHECK_AWS_BUCKET</code></td>
  </tr>
  <tr>
    <td><code>awsRegion</code></td>
    <td>The AWS <code>region</code> for an S3 bucket.</td>
    <td><code>string</code></td>
    <td><code>local</code></td>
    <td><code>$LIGHTHOUSE_CHECK_AWS_REGION</code></td>
  </tr>
  <tr>
    <td><code>awsSecretAccessKey</code></td>
    <td>The AWS <code>secretAccessKey</code> for an S3 bucket.</td>
    <td><code>string</code></td>
    <td><code>local</code></td>
    <td><code>$LIGHTHOUSE_CHECK_AWS_SECRET_ACCESS_KEY</code></td>
  </tr>
  <tr>
    <td><code>branch</code></td>
    <td>For Slack notifications: A version control branch, typically from GitHub.</td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>$CIRCLE_BRANCH</code></td>
  </tr>
  <tr>
    <td><code>configFile</code></td>
    <td>A configuration file path in JSON format which holds all options defined here. This file should be relative to the file being interpretted. In this case it will most likely be the root of the repo ("./")</td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>emulatedFormFactor</code></td>
    <td>Lighthouse setting only used for local audits. See <a href="https://github.com/foo-software/lighthouse-check/tree/master/src/lighthouseConfig.js"><code>lighthouse-check</code></a> comments for details.</td>
    <td><code>oneOf(['mobile', 'desktop']</code></td>
    <td><code>local</code></td>
    <td><code>mobile</code></td>
  </tr>
  <tr>
    <td><code>extraHeaders</code></td>
    <td>Stringified HTTP Header object key/value pairs to send in requests. example: <code>'{ "x-hello-world": "foobar", "x-some-other-thing": "hi" }'</code></td>
    <td><code>string</code></td>
    <td><code>local</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>locale</code></td>
    <td>A locale for Lighthouse reports. Example: <code>ja</code></td>
    <td><code>string</code></td>
    <td><code>local</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>maxWaitForLoad</code></td>
    <td>The maximum amount of time to wait for a page to load in ms.</td>
    <td><code>number</code></td>
    <td><code>local</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>overridesJsonFile</code></td>
    <td>A JSON file with config and option fields to overrides defaults. <a href="#usage-overriding-config-and-option-defaults">Read more here</a>.</td>
    <td><code>string</code></td>
    <td><code>local</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>pr</code></td>
    <td>For Slack notifications: A version control pull request URL, typically from GitHub.</td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>prCommentAccessToken</code></td>
    <td><a href="https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line">Access token</a> of a user to post PR comments.</td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>prCommentEnabled</code></td>
    <td>If <code>true</code> and <code>prCommentAccessToken</code> is set along with <code>prCommentUrl</code>, scores will be posted as comments.</td>
    <td><code>boolean</code></td>
    <td><code>both</code></td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>prCommentSaveOld</code></td>
    <td>If <code>true</code> and PR comment options are set, new comments will be posted on every change vs only updating once comment with most recent scores.</td>
    <td><code>boolean</code></td>
    <td><code>both</code></td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>prCommentUrl</code></td>
    <td>An endpoint to post comments to. Typically this will from <a href="https://developer.github.com/v3/pulls/reviews/#create-a-pull-request-review">GitHub's API</a>. Example: <code>https://api.github.com/repos/:owner/:repo/pulls/:pull_number/reviews</code></td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>sha</code></td>
    <td>For Slack notifications: A version control <code>sha</code>, typically from GitHub.</td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>slackWebhookUrl</code></td>
    <td>A Slack Incoming Webhook URL to send notifications to.</td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>$LIGHTHOUSE_CHECK_SLACK_WEBHOOK_URL</code></td>
  </tr>
  <tr>
    <td><code>throttling</code></td>
    <td>Lighthouse setting only used for local audits. See <a href="https://github.com/foo-software/lighthouse-check/tree/master/src/lighthouseConfig.js"><code>lighthouse-check</code></a> comments for details.</td>
    <td><code>oneOf(['mobileSlow4G', 'mobileRegluar3G'])</code></td>
    <td><code>local</code></td>
    <td><code>mobileSlow4G</code></td>
  </tr>
  <tr>
    <td><code>tag</code></td>
    <td>An optional tag or name (example: <code>build #2</code> or <code>v0.0.2</code>).</td>
    <td><code>string</code></td>
    <td><code>remote</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>throttlingMethod</code></td>
    <td>Lighthouse setting only used for local audits. See <a href="https://github.com/foo-software/lighthouse-check/tree/master/src/lighthouseConfig.js"><code>lighthouse-check</code></a> comments for details.</td>
    <td><code>oneOf(['simulate', 'devtools', 'provided'])</code></td>
    <td><code>local</code></td>
    <td><code>simulate</code></td>
  </tr>
  <tr>
    <td><code>timeout</code></td>
    <td>Minutes to timeout. If <code>wait</code> is <code>true</code> (it is by default), we wait for results. If this timeout is reached before results are received an error is thrown.</td>
    <td><code>string</code></td>
    <td><code>local</code></td>
    <td><code>10</code></td>
  </tr>
  <tr>
    <td><code>urls</code></td>
    <td>A comma-separated list of URLs to be audited.</td>
    <td><code>string</code></td>
    <td><code>both</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>wait</code></td>
    <td>If <code>true</code>, waits for all audit results to be returned, otherwise URLs are only enqueued.</td>
    <td><code>boolean</code></td>
    <td><code>remote</code></td>
    <td><code>true</code></td>
  </tr>
</table>

## Usage

Below are example combinations of ways to use this Orb.

## Usage: Standard Example

In the below example we run Lighthouse on two URLs, log scores, save the HTML reports as artifacts, upload reports to AWS S3, notify via Slack with details about the change from Git data.

```yaml
version: 2.1

orbs:
  lighthouse-check: foo-software/lighthouse-check@0.0.6 # ideally later :)

jobs:
  test: 
    executor: lighthouse-check/default
    steps:
      - lighthouse-check/audit:
          urls: https://www.foo.software,https://www.foo.software/contact
          # this serves as an example, however if the below environment variables
          # are set - the below params aren't even necessary. for example - if
          # LIGHTHOUSE_CHECK_AWS_ACCESS_KEY_ID is already set - you don't need
          # the line below.
          awsAccessKeyId: $LIGHTHOUSE_CHECK_AWS_ACCESS_KEY_ID
          awsBucket: $LIGHTHOUSE_CHECK_AWS_BUCKET
          awsRegion: $LIGHTHOUSE_CHECK_AWS_REGION
          awsSecretAccessKey: $LIGHTHOUSE_CHECK_AWS_SECRET_ACCESS_KEY
          slackWebhookUrl: $LIGHTHOUSE_CHECK_SLACK_WEBHOOK_URL

workflows:
  test:
    jobs:
      - test
```

## Usage: Failing Workflows by Enforcing Minimum Scores

We can optionally fail a workflow if minimum scores aren't met. We do this using the `validate-status` command.

```yaml
version: 2.1

orbs:
  lighthouse-check: foo-software/lighthouse-check@0.0.6 # ideally later :)

jobs:
  test: 
    executor: lighthouse-check/default
    steps:
      - lighthouse-check/audit:
          urls: https://www.foo.software,https://www.foo.software/contact
      - lighthouse-check/validate-status:
          minAccessibilityScore: "50"
          minBestPracticesScore: "50"
          minPerformanceScore: "99"
          minProgressiveWebAppScore: "50"
          minSeoScore: "50"

workflows:
  test:
    jobs:
      - test
```

## Usage: Foo API

[Foo's Automated Lighthouse Check](https://www.foo.software/lighthouse) can monitor your website's quality by running audits automatically! It can provide a historical record of audits over time to track progression and degradation of website quality. [Create a free account](https://www.foo.software/register) to get started. With this, not only will you have automatic audits, but also any that you trigger additionally. Below are steps to trigger audits on URLs that you've created in your account.

#### Trigger Audits on All Pages in an Account

- Navigate to [your account details](https://www.foo.software/account), click into "Account Management" and make note of the "API Token".
- Use the account token as the [`apiToken` parameter](#parameters).

> Basic example

```yaml
usage:
  version: 2.1

  orbs:
    lighthouse-check: foo-software/lighthouse-check@0.0.7 # ideally later :)

  jobs:
    test: 
      executor: lighthouse-check/default
      steps:
        - lighthouse-check/audit:
            apiToken: $LIGHTHOUSE_CHECK_API_TOKEN

  workflows:
    test:
      jobs:
        - test
```

#### Trigger Audits on Only Certain Pages in an Account

- Navigate to [your account details](https://www.foo.software/account), click into "Account Management" and make note of the "API Token".
- Navigate to [your dashboard](https://www.foo.software/dashboard) and once you've created URLs to monitor, click on the "More" link of the URL you'd like to use. From the URL details screen, click the "Edit" link at the top of the page. You should see an "API Token" on this page. It represents the token for this specific page (not to be confused with an **account** API token).
- Use the account token as the [`apiToken` parameter](#parameters) and page token (or group of page tokens) as [`urls` parameter](#parameters).

> Basic example

```yaml
usage:
  version: 2.1

  orbs:
    lighthouse-check: foo-software/lighthouse-check@0.0.8 # ideally later :)

  jobs:
    test: 
      executor: lighthouse-check/default
      steps:
        - lighthouse-check/audit:
            apiToken: $LIGHTHOUSE_CHECK_API_TOKEN
            urls: 'mypagetoken1,mypagetoken2'

  workflows:
    test:
      jobs:
        - test
```

> Example with pull request comments

```yaml
usage:
  version: 2.1

  orbs:
    lighthouse-check: foo-software/lighthouse-check@0.0.8 # ideally later :)

  jobs:
    test: 
      executor: lighthouse-check/default
      steps:
        - lighthouse-check/audit:
            apiToken: $LIGHTHOUSE_CHECK_API_TOKEN
            prCommentAccessToken: $LIGHTHOUSE_CHECK_ACCESS_TOKEN
            prCommentUrl: https://api.github.com/repos/foo-software/lighthouse-check-orb/pulls/${CIRCLE_PULL_REQUEST##*/}/reviews
            urls: 'mypagetoken1,mypagetoken2'

  workflows:
    test:
      jobs:
        - test
```

## Usage: Overriding Config and Option Defaults

> **Note:** this approach is only available when running "locally" (not using the REST API)

You can override default config and options by specifying `overridesJsonFile` option which is consumed by [`path.resolve(overridesJsonFile)`](https://nodejs.org/api/path.html#path_path_resolve_paths). Contents of this overrides JSON file can have two possible fields; `options` and `config`. These two fields are eventually used by Lighthouse to populate `opts` and `config` arguments respectively as illustrated in [Using programmatically](https://github.com/GoogleChrome/lighthouse/blob/master/docs/readme.md#using-programmatically). The two objects populating this JSON file are merged shallowly with the default [config](https://github.com/foo-software/lighthouse-check/blob/master/src/__snapshots__/lighthouseConfig.test.js.snap) and [options](https://github.com/foo-software/lighthouse-check/blob/master/src/__snapshots__/lighthouseOptions.test.js.snap).

> Example content of `overridesJsonFile`

```json
{
  "config": {
    "settings": {
      "onlyCategories": ["performance"]
    }
  },
  "options": {
    "disableStorageReset": true
  }
}
```

## Credits

> <img src="https://lighthouse-check.s3.amazonaws.com/images/logo-simple-blue-light-512.png" width="100" height="100" align="left" /> This package was brought to you by [Foo - a website performance monitoring tool](https://www.foo.software). Create a **free account** with standard performance testing. Automatic website performance testing, uptime checks, charts showing performance metrics by day, month, and year. Foo also provides real time notifications. Users can integrate email, Slack and PagerDuty notifications.
