# Fetch Amazon

This a proof of concept app that receives an Amazon product ASIN and get the page from Amazon website, extracting dimensions, categories and ranking. It has been built Rails on the Backend and React on the FrontEnd.

## How to run it
- Install [Ruby 2.5.1](https://www.ruby-lang.org/en/downloads/), [bundler](https://bundler.io), and [Postresql](https://www.postgresql.org)
- Install [node](https://nodejs.org/en/), and [yarn](https://yarnpkg.com/en/)
- Clone the repo
- run `./bin/setup`
- Start the server `./bin/rails s`
- Access http://localhost:3000

## Todo
- Ruby code is heavily tested, but React components still needs to be tested.
