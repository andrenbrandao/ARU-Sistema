#Sistema de Cadastros da ARU!

##Steps to Start

Make sure to install `rvm` to use the correct Ruby and Rails versions.

ruby version: `ruby-1.9.3-p484`

rails: `3.2.8`

- `gem install foreman`
- `bundle install`

### Set up the database

- Install PostgreSQL
- Set up databases like the ones in `database.yml` (cadastro_development)
- Run `rake db:migrate`

### Run seeds to populate the database with test data

`rake db:seed`

**Check seeds for usernames and passwords**

### Testing
Run command `guard` to keep testing while developing

- It will use RSpec to test

### Running

- Execute `foreman start`
- Open localhost:5000 in browser