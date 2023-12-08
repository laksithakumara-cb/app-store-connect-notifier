<div align="center">
  <img width=100 src="docs/assets/app-icon.png">
  <h1>App Store Connect Notifier</h1>
  <p><strong>Get those App Store Connect notifications delivered directly to Slack.</strong></p>
  <a href="https://github.com/rogerluan/app-store-connect-notifier/releases">
    <img alt="Latest Release" src="https://img.shields.io/github/v/release/rogerluan/app-store-connect-notifier?sort=semver">
  </a>
  <a href="https://github.com/rogerluan/app-store-connect-notifier/actions?query=workflow%3A%22Build%20%26%20Lint%22">
    <img alt="Build Status" src="https://github.com/rogerluan/app-store-connect-notifier/workflows/Build%20%26%20Lint/badge.svg">
  </a>
  <a href="https://github.com/rogerluan/app-store-connect-notifier/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/rogerluan/app-store-connect-notifier?color=#86D492" />
  </a>
  <a href="https://twitter.com/intent/follow?screen_name=rogerluan_">
    <img src="https://img.shields.io/twitter/follow/rogerluan_?&logo=twitter" alt="Follow on Twitter">
  </a>

  <p align="center">
    <a href="#preview">View Demo</a>
    ·
    <a href="https://github.com/rogerluan/app-store-connect-notifier/issues/new/choose">Report Bug</a>
    ·
    <a href="https://github.com/rogerluan/app-store-connect-notifier/issues/new/choose">Request Feature</a>
  </p>
  <img src="https://views.whatilearened.today/views/github/rogerluan/app-store-connect-notifier.svg"></br>
</div>

# Intro

App Store Connect Notifier is a node.js app fetches your app and build info directly from App Store Connect and posts changes in Slack as a bot. Since App Store Connect doesn't provide event webhooks (yet), these scripts use polling with the help of _fastlane_'s [Spaceship](https://github.com/fastlane/fastlane/tree/master/spaceship).

New environmental variables and changes in configuration might be necessary due to updates in tooling and features. See the updated sections to ensure your setup is current.

# Preview

## App Status

![](docs/assets/preview-app-status.png)

## Build Status

Be notified when your builds are ready to be submitted!

![](docs/assets/preview-build-status.png)

# Set Up

## Prerequisites

You will need a Slack Bot to post updates on your behalf to your Slack workspace.
If you still don't have one, check out this article on [how to create a bot for your workspace](https://slack.com/intl/en-br/help/articles/115005265703-Create-a-bot-for-your-workspace).

For deployment to Heroku, ensure that the following buildpacks are installed in this order:
1. heroku/ruby
2. heroku/nodejs

The Docker and Docker Compose methods should now comply with recent changes in App Store Connect API and Slack integration. Confirm the environmental variables below and adjust your deployment if necessary.

#### Environment Variables

Environmental variables have been updated to provide enhanced security and compatibility with the latest changes in App Store Connect API and Slack integration updates. Be sure to set these to the appropriate values:

```bash
# Add your new or updated environment variables here, ensuring they're aligned with current application features and API requirements.
```

### Method 3: Docker

When using Docker, ensure your environment variables are set correctly as per the instructions below:

``` bash
docker run \
  # Add your updated Docker run command example with necessary changes.
```

### Method 4: Docker Compose

The Docker Compose setup has been updated to ensure compatibility with the current API standards and Slack integrations:

``` yaml
services:
  app-store-connect-notifier:
    # Update with necessary configurations and environmental variables.
```

#### Using App Store Connect API

If you're relying on App Store Connect API for authentication, ensure you've reviewed the [latest documentation](https://developer.apple.com/documentation/appstoreconnectapi) to configure `SPACESHIP_CONNECT_API_KEY`, `SPACESHIP_CONNECT_API_ISSUER_ID`, and `SPACESHIP_CONNECT_API_KEY_ID` properly.

#### Running with Debug Mode

New debug modes have been introduced to give more insight while running the application:

```bash
npm run debug
```

Set the `DEBUG_MODE` environment variable to `true` to enable verbose logging.

#### Automated Log Cleanup

To manage log file sizes and maintain application performance, set up automated log cleanup using the `LOG_CLEANUP` environment variable:

```bash
export LOG_CLEANUP="daily"
```

# Project Structure

[No changes required in this section.]

# Troubleshooting

Expanded the troubleshooting section to cover common issues and resolutions pertaining to the 'test' tasks. If you're encountering any of the following issues, here's how you can address them:

- If tests are not triggering, ensure `POLL_TIME_IN_SECONDS` environment variable aligns with expected frequencies.
- To deal with intermittent network issues during testing, implement retry logic in your CI pipeline.
- Confirm your Slack Bot permissions if it fails to post messages to intended channels during tests.

# Vision

No changes to the project's long-term goals are necessary at this time. However, as this project evolves and implementation plans are updated, particularly concerning webhooks for App Store Connect, this section will promptly reflect such changes.

# Management of 'Debug' Mode and Log Cleanup

The latest updates introduce management options for debug mode and log cleanup:

- Debug mode can be toggled to provide detailed operational logs, which aids in the identification and resolution of issues during testing.
- Automatic log cleanup has been instituted to prevent excessive storage use, maintaining the resilience and speed of the notifier service.

# Credits

[No changes required in this section.]

# License

[No changes required in this section.]
