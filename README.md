# Kalo Challenge

This is a simple Rails API for querying a table of users extracted from a provided CSV.

https://kalo-api-challenge.herokuapp.com/api-docs/index.html

## Installation

Ruby version: `2.6.0`

I chose to use PostgreSQL for the database because parsing CSV data naturally fits into a table/column format, and Postgres's native JSONB column type allows for more efficient querying for JSON or array-type data than other relational databases such as MySQL.

PostgreSQL can be installed using Homebrew:
```bash
brew install postgresql
```

```bash
bundle install
rails db:setup # this will create, migrate, and seed your database
```

## Usage

Run your Rails server:
```bash
rails s
```

I chose to document the API with RSwag, a tool that can generate Swagger API documentation for Rails APIs.
Open your browser to http://localhost:3000/api-docs

To (re)generate docs:
```bash
bundle exec rake rswag:specs:swaggerize
```
![docs index query](https://kalo-api-challenge.herokuapp.com/api-doc_index_query.png)

![docs index result](https://kalo-api-challenge.herokuapp.com/api-doc_index_result.png)

## Tests
RSpec is one of the most popular Ruby testing frameworks.

Run RSpec tests using the command:
```bash
rspec spec
```
