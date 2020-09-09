# Threads

Site URL: https://threads-poc.herokuapp.com/

## Development

### Prerequisites

- [node LTS (v12)](https://nodejs.org/en/download/)
- [docker](https://docs.docker.com/get-docker/)

### Getting started

1. Open a terminal
2. Install dependencies using the command `npm install`
3. Run the site using `npm run dev`
4. Go to http://localhost:8080

### Running tests

#### Full test suite

The full test suite needs to be run before doing any push to master. That's to
prevent ourselves from breaking the live version of the website. Follow these
steps before each push to master:

1. Open a terminal
2. Run `./build.sh`
3. If you get a "SUCCESS" message, you can push. If you get a failed message or
   any other error, do not push. Fix the problem and then run the tests again
   before pushing.

#### Other tests

During development, you might just want to run a subset of the tests locally.

- Unit and integration tests: `npm run test` or `npm run test:watch`
- Acceptance tests: `npm run test:acceptance`
