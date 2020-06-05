<p align="center">
  <h1 align="center">Simple Search</h1>
  <p align="center"><strong>Simple search engine with analytics</strong></p>
</p>
<br>
<p align="center">
  <a href="https://www.ruby-lang.org/en/">
    <img src="https://img.shields.io/badge/Ruby-v2.6.5-brightgreen.svg" alt="ruby version">
  </a>
  <a href="http://rubyonrails.org/">
    <img src="https://img.shields.io/badge/Rails-v6.0.3-brightgreen.svg" alt="rails version">
  </a>
</p>

Welcome to the [Simple Search](https://helpjuice-simple-search.herokuapp.com/) codebase. We are so excited to have you.

## What is Simple Search?

Simple search is an open simple text metching software, which saves users searches and displays them in analytics per user bases.

## How does it work?

Simple search will save queries from users session, session is started from the moment that user starts typing his query until he changes the page (goes to an article or analytics) or clears the input box.

In cases where user executes more than one valid queries in same session ('How to buy product', 'How to sell product') we will save bouth of those queries. In cases when user is typing slow and is sending multiple requests in single query all other queries from users session will be deleted.

Every query will have session identification saved as well as used id (that is comming from users IP address), counter on how many times did user make a same query (here i tought about saving every query and not incrementing them so that I can get when the query was created), boolean on wether we ware able to find the results.

We also clean every query from special caracters and leading or trailing white spaces.

Every user has access to his analytics board which will show total nubmer of ther searches, number of successful as well as unsuccessful searches, and articles count. Also in bottom section user can see his most searched terms, successful and unsuccessful ones. Graph will show number of searches per minute, I understand that it is little bit redundant but since this app will be used and tested in shorter time interval I wanted to plot some sort of graph for you to see.

## Getting Started

This section provides a quick start guide.

We run on a full-stack [Rails](https://rubyonrails.org/) application.

### Prerequisites

- [Ruby](https://www.ruby-lang.org/en/): we recommend using
  [rbenv](https://github.com/rbenv/rbenv) to install the Ruby version listed on
  the badge.
- [Yarn](https://yarnpkg.com/): please refer to their
  [installation guide](https://yarnpkg.com/en/docs/install).
- [PostgreSQL](https://www.postgresql.org/) 9.4 or higher.

### Installation Documentation

1. Clone the repo with `git clone git@github.com:EmirVatric/simple_search.git`.
2. Steps to install gems:
   - You may need to first run `bundle install` if you have older gems in your environment from previous Rails work. If you get an error message like `Your Ruby version is 2.x.x, but your Gemfile specified 2.6.5` then you need to install the ruby version 2.6.5 using `rvm` or `rbenv`.
     - Using **rvm**: `rvm install 2.6.5` followed by `rvm use 2.6.5`
     - Using **rbenv**: `rbenv install 2.6.5` followed by `rbenv local 2.6.5`
   - Install gems with `bundle install` from the rails root folder, to install the gems you'll need.
3. Run `rails db:create` followed by `rails db:migrate` and `rails db:seed` to set up the database
4. Install static assets (like external javascript libraries, fonts) with `yarn install`
5. Run `rails s` to start the server.
6. Run `rspec` to run tests

<br>

<p align="center">
  <strong>Happy Testing</strong> ❤️
</p>
