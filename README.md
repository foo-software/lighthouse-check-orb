# Lighthouse Check Orb

A CircleCI Orb for running Lighthouse audits automatically in a workflow with a rich set of extra features. Simple implementation or advanced customization including **Slack** notifications, **AWS S3** HTML report uploads, and more!

<table>
  <tr>
    <td>
      <img alt="Lighthouse" src="https://lighthouse-check.s3.amazonaws.com/images/github-actions/lighthouse-logo.png" />
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
- 💗 Save HTML reports locally.
- 💚 Upload HTML reports as artifacts.
- 💙 Upload HTML reports to AWS S3.
- 💜 **Slack** notifications.
- 💖 Slack notifications **with Git info** (author, branch, PR, etc).

## Parameters

All fields are optional with the exception of either `urls` or `configFile`.

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>author</code></td>
    <td>For Slack notifications: A user handle, typically from GitHub.</td>
    <td><code>string</code></td>
    <td><code>$CIRCLE_USERNAME</code></td>
  </tr>
  <tr>
    <td><code>branch</code></td>
    <td>For Slack notifications: A version control branch, typically from GitHub.</td>
    <td><code>string</code></td>
    <td><code>$CIRCLE_BRANCH</code></td>
  </tr>
  <tr>
    <td><code>awsAccessKeyId</code></td>
    <td>The AWS <code>accessKeyId</code> for an S3 bucket.</td>
    <td><code>string</code></td>
    <td><code>$LIGHTHOUSE_CHECK_AWS_ACCESS_KEY_ID</code></td>
  </tr>
  <tr>
    <td><code>awsBucket</code></td>
    <td>The AWS <code>Bucket</code> for an S3 bucket.</td>
    <td><code>string</code></td>
    <td><code>$LIGHTHOUSE_CHECK_AWS_BUCKET</code></td>
  </tr>
  <tr>
    <td><code>awsRegion</code></td>
    <td>The AWS <code>region</code> for an S3 bucket.</td>
    <td><code>string</code></td>
    <td><code>$LIGHTHOUSE_CHECK_AWS_REGION</code></td>
  </tr>
  <tr>
    <td><code>awsSecretAccessKey</code></td>
    <td>The AWS <code>secretAccessKey</code> for an S3 bucket.</td>
    <td><code>string</code></td>
    <td><code>$LIGHTHOUSE_CHECK_AWS_SECRET_ACCESS_KEY</code></td>
  </tr>
  <tr>
    <td><code>configFile</code></td>
    <td>A configuration file path in JSON format which holds all options defined here. This file should be relative to the file being interpretted. In this case it will most likely be the root of the repo ("./")</td>
    <td><code>string</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>emulatedFormFactor</code></td>
    <td>Lighthouse setting only used for local audits. See <a href="https://github.com/foo-software/lighthouse-check/tree/master/src/lighthouseConfig.js"><code>lighthouse-check</code></a> comments for details.</td>
    <td><code>oneOf(['mobile', 'desktop']</code></td>
    <td><code>mobile</code></td>
  </tr>
  <tr>
    <td><code>locale</code></td>
    <td>A locale for Lighthouse reports. Example: <code>ja</code></td>
    <td><code>string</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>outputDirectory</code></td>
    <td>An absolute directory path to output report. You can do this an an alternative or combined with an S3 upload.</td>
    <td><code>string</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>pr</code></td>
    <td>For Slack notifications: A version control pull request URL, typically from GitHub.</td>
    <td><code>string</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>slackWebhookUrl</code></td>
    <td>A Slack Incoming Webhook URL to send notifications to.</td>
    <td><code>string</code></td>
    <td><code>$LIGHTHOUSE_CHECK_SLACK_WEBHOOK_URL</code></td>
  </tr>
  <tr>
    <td><code>sha</code></td>
    <td>For Slack notifications: A version control <code>sha</code>, typically from GitHub.</td>
    <td><code>string</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>throttlingMethod</code></td>
    <td>Lighthouse setting only used for local audits. See <a href="https://github.com/foo-software/lighthouse-check/tree/master/src/lighthouseConfig.js"><code>lighthouse-check</code></a> comments for details.</td>
    <td><code>oneOf(['simulate', 'devtools', 'provided'])</code></td>
    <td><code>simulate</code></td>
  </tr>
  <tr>
    <td><code>throttling</code></td>
    <td>Lighthouse setting only used for local audits. See <a href="https://github.com/foo-software/lighthouse-check/tree/master/src/lighthouseConfig.js"><code>lighthouse-check</code></a> comments for details.</td>
    <td><code>oneOf(['mobileSlow4G', 'mobileRegluar3G'])</code></td>
    <td><code>mobileSlow4G</code></td>
  </tr>
  <tr>
    <td><code>urls</code></td>
    <td>A comma-separated list of URLs to be audited.</td>
    <td><code>string</code></td>
    <td><code>undefined</code></td>
  </tr>
  <tr>
    <td><code>verbose</code></td>
    <td>If <code>true</code>, print out steps and results to the console.</td>
    <td><code>boolean</code></td>
    <td><code>true</code></td>
  </tr>
</table>

## Example Usage

In the below example we run Lighthouse on two URLs, log scores, save the HTML reports as artifacts, upload reports to AWS S3, notify via Slack with details about the change from Git data.

```yaml
version: 2.1

orbs:
  lighthouse-check: foo-software/lighthouse-check@0.0.1 # ideally a later version :)

workflows:
  some-workflow:
    jobs:
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
```
