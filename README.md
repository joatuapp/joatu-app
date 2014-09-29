README
======

[![Code Climate](https://codeclimate.com/github/joatuapp/joatu-app.png)](https://codeclimate.com/github/joatuapp/joatu-app)
[![Build Status](https://travis-ci.org/joatuapp/joatu-app.svg?branch=develop)](https://travis-ci.org/joatuapp/joatu-app)
[![Test Coverage](https://codeclimate.com/github/joatuapp/joatu-app/badges/coverage.svg)](https://codeclimate.com/github/joatuapp/joatu-app)

About the Project
-----------------
The Jack Of All Trade Universe is an online marketplace for self-organized exchanges. The JoatUnit is a currency that is generated to promote community activities such as planting community gardens or teaching classes. More information can be found at [joatu.com](http://www.joatu.com)

Contributions
-------------
Contributions are welcome. If you wish to help with the project, please consider [donating to our crowdfunding campaign](http://love.joatu.com) or [contact us about volunteering](http://joatu.com/alpha/volunteer/)

If you are a Ruby on Rails or Javascript developer and are interested in contributing to JoatU we'd especially love to hear from you! JoatU is currently being programmed by volunteers, and another pair of hands is always welcome. If you're interested please [contact us](http://joatu.com/alpha/volunteer/) and we'll be in touch with more details of what we're currently working on so you can choose a feature and get started!

Getting Started
--------------
You can run JoatU locally by following these steps:
* Ensure your system meets the requirements:
  * [Ruby](https://www.ruby-lang.org/en/) installed. (check the .ruby-version
    file for the exact version we're currently using!)
  * [Postgress 9.3](http://www.postgresql.org/download/) installed, with the [Postgis](http://postgis.net/) extension also installed.
* Clone this repository 
* Change to the repository root: `cd joatu-app`
* Run `bundle install`
* Run `bundle exec thor joatu setup`. This will configure the database.
* Run `bundle exec foreman start` to start unicorn & postgres.   
* Visit localhost:8080 to view the site.
