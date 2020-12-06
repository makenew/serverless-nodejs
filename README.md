# Serverless Node.js Project Skeleton

[![npm](https://img.shields.io/npm/v/@makenew/serverless-nodejs.svg)](https://www.npmjs.com/package/@makenew/serverless-nodejs)
[![CircleCI](https://img.shields.io/circleci/project/github/makenew/serverless-nodejs.svg)](https://circleci.com/gh/makenew/serverless-nodejs)

Package skeleton for a Node.js Serverless project on AWS Lambda.

## Description

Bootstrap a new Node.js Serverless project in five minutes or less.

### Features

- Deploy to [AWS Lambda] under a
  [custom domain][serverless-domain-manager] with [Serverless].
- [Node.js]'s [npm] package structure.
- Fast, reliable, and secure dependency management with [Yarn].
- Next generation JavaScript with [Babel].
- Examples with configurable options and arguments powered by [examplr].
- Linting with the [JavaScript Standard Style] using [ESLint].
- [Prettier] code.
- Futuristic debuggable unit testing with [AVA].
- Code coverage reporting with [Istanbul] and [nyc].
- Continuous testing and automated package publishing with [CircleCI].
- [Keep a CHANGELOG].
- Consistent coding with [EditorConfig].
- Badges from [Shields.io].

[AVA]: https://github.com/avajs/ava
[AWS Lambda]: https://aws.amazon.com/lambda/
[Babel]: https://babeljs.io/
[CircleCI]: https://circleci.com/
[ESLint]: https://eslint.org/
[EditorConfig]: https://editorconfig.org/
[Istanbul]: https://istanbul.js.org/
[JavaScript Standard Style]: https://standardjs.com/
[Keep a CHANGELOG]: https://keepachangelog.com/
[Node.js]: https://nodejs.org/
[Prettier]: https://prettier.io/
[Serverless]: https://serverless.com/
[Shields.io]: https://shields.io/
[Yarn]: https://yarnpkg.com/
[examplr]: https://github.com/meltwater/node-examplr
[npm]: https://www.npmjs.com/
[nyc]: https://github.com/istanbuljs/nyc
[serverless-domain-manager]: https://github.com/amplify-education/serverless-domain-manager

### Bootstrapping a new project

1. Create an empty (**non-initialized**) repository on GitHub.
2. Clone the master branch of this repository with
   ```
   $ git clone --single-branch git@github.com:makenew/serverless-nodejs.git <new-node-lib>
   $ cd <new-node-lib>
   ```
   Optionally, reset to the latest version with
   ```
   $ git reset --hard <version-tag>
   ```
3. Run
   ```
   $ ./makenew.sh
   ```
   This will replace the boilerplate, delete itself,
   remove the git remote, remove upstream tags,
   and stage changes for commit.
4. Create the required CircleCI environment variables with
   ```
   $ .circleci/envvars.sh
   ```
5. Review, commit, and push the changes to GitHub with
   ```
   $ git diff --cached
   $ git commit -m "Replace makenew boilerplate"
   $ git remote add origin git@github.com:<user>/<new-node-lib>.git
   $ git push -u origin master
   ```
6. Ensure the CircleCI build passes,
   then publish the initial version of the package with
   ```
   $ nvm install
   $ yarn install
   $ npm version patch
   ```
7. Ensure a valid certificate exists in [AWS Certificate Manager]
   that matches the custom deployment domains,
   e.g., this project uses a wildcard certificate for
   `*.serverless-nodejs.makenew.razorx.app`.
   Then trigger a deploy to the test stage with
   ```
   $ yarn run release:test
   ```

[AWS Certificate Manager]: https://aws.amazon.com/certificate-manager/

### Updating from this skeleton

If you want to pull in future updates from this skeleton,
you can fetch and merge in changes from this repository.

Add this as a new remote with

```
$ git remote add upstream git@github.com:makenew/serverless-nodejs.git
```

You can then fetch and merge changes with

```
$ git fetch --no-tags upstream
$ git merge upstream/master
```

#### Changelog for this skeleton

Note that `CHANGELOG.md` is just a template for this skeleton.
The actual changes for this project are documented in the commit history
and summarized under [Releases].

[Releases]: https://github.com/makenew/serverless-nodejs/releases

## Installation

Add this as a dependency to your project using [npm] with

```
$ npm install @makenew/serverless-nodejs
```

or using [Yarn] with

```
$ yarn add @makenew/serverless-nodejs
```

[npm]: https://www.npmjs.com/
[Yarn]: https://yarnpkg.com/

## Development and Testing

### Quickstart

```
$ git clone https://github.com/makenew/serverless-nodejs.git serverless-nodejs
$ cd serverless-nodejs
$ nvm install
$ yarn install
```

Run the command below in a separate terminal window:

```
$ yarn run test:watch
```

Primary development tasks are defined under `scripts` in `package.json`
and available via `yarn run`.
View them with

```
$ yarn run
```

### Source code

The [source code] is hosted on GitHub.
Clone the project with

```
$ git clone git@github.com:makenew/serverless-nodejs.git
```

[source code]: https://github.com/makenew/serverless-nodejs

### Requirements

You will need [Node.js] with [npm], [Yarn], and a [Node.js debugging] client.

Be sure that all commands run under the correct Node version, e.g.,
if using [nvm], install the correct version with

```
$ nvm install
```

Set the active version for each shell session with

```
$ nvm use
```

Install the development dependencies with

```
$ yarn install
```

[Node.js]: https://nodejs.org/
[Node.js debugging]: https://nodejs.org/en/docs/guides/debugging-getting-started/
[npm]: https://www.npmjs.com/
[nvm]: https://github.com/creationix/nvm

### Publishing

Use the [`npm version`][npm-version] command to release a new version.
This will push a new git tag which will trigger a CircleCI publish job.

Publishing may be triggered using on the web
using a [version workflow_dispatch on GitHub Actions].

[npm-version]: https://docs.npmjs.com/cli/version
[version workflow_dispatch on GitHub Actions]: https://github.com/makenew/serverless-nodejs/actions?query=workflow%3Aversion

### Deployment

Deployment is triggered on CircleCI when a git tag matching
`stage.<environment>` is created or updated.
Use `yarn run release:<environment>` to do this automatically, e.g.,

```
$ yarn run release:test
```

Releases may be triggered using on the web
using a [release workflow_dispatch on GitHub Actions].

[npm-version]: https://docs.npmjs.com/cli/version
[release workflow_dispatch on GitHub Actions]: https://github.com/makenew/serverless-nodejs/actions?query=workflow%3Arelease

## CircleCI

_CircleCI should already be configured: this section is for reference only._

The following environment variables must be set on [CircleCI]:

- `NPM_TOKEN`: npm token for installing and publishing packages.
- `AWS_DEFAULT_REGION`: The AWS region Serverless will deploy to.
- `AWS_ACCESS_KEY_ID`: AWS access key ID.
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key.

These may be set manually or by running the script `./.circleci/envvars.sh`.

[CircleCI]: https://circleci.com/

## GitHub Actions

*GitHub Actions should already be configured: this section is for reference only.*

The following secrets must be set on the GitHub repo.

- `GPG_PRIVATE_KEY`: The [GPG private key].
- `GPG_PASSPHRASE`: The GPG key passphrase.
- `GIT_USER_NAME`: The name to set for Git commits.
- `GIT_USER_EMAIL`: The email to set for Git commits.

[GPG private key]: https://github.com/marketplace/actions/import-gpg#prerequisites

## Contributing

Please submit and comment on bug reports and feature requests.

To submit a patch:

1. Fork it (https://github.com/makenew/serverless-nodejs/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Make changes.
4. Commit your changes (`git commit -am 'Add some feature'`).
5. Push to the branch (`git push origin my-new-feature`).
6. Create a new Pull Request.

## License

This Serverless project is licensed under the MIT license.

## Warranty

This software is provided by the copyright holders and contributors "as is" and
any express or implied warranties, including, but not limited to, the implied
warranties of merchantability and fitness for a particular purpose are
disclaimed. In no event shall the copyright holder or contributors be liable for
any direct, indirect, incidental, special, exemplary, or consequential damages
(including, but not limited to, procurement of substitute goods or services;
loss of use, data, or profits; or business interruption) however caused and on
any theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use of this
software, even if advised of the possibility of such damage.
