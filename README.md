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
If you are a Ruby on Rails or Javascript developer and are interested in contributing to JoatU we'd love to hear from you! JoatU is currently being programmed by volunteers, and another pair of hands is always welcome. Please feel free to clone or fork the library and explore the code-base. Setup instructions can be found below under "Getting Started", and if you have any issues or feedback on getting the app running, please open an issue (and tag it "development-environment", please).

We use Github Issues for bugs & issue tracking, and specifically the ["help
wanted"
tag](https://github.com/joatuapp/joatu-app/issues?q=is%3Aopen+is%3Aissue+label%3A%22help+wanted%22)
for issues that have been triaged and are most ready for outside help. That
  said, any open, unassigned bug is fair game, with the exception that issues tagged 
  ["request-for-comment"](https://github.com/joatuapp/joatu-app/labels/request-for-comment)
  are currently under discussion and so should not be worked on.

  If you fix an issue, please submit a pull request with your fix, using "fixes
  #\<issue-number\>" in the pull request body so that the issue will
  auto-close when your pull request is merged. If you are fixing a backend bug
  (Ruby) please include a unit test that will catch any regression of the
  fixed bug.

If you are not a programmer but still wish contribute please [contact us about volunteering.](http://joatu.com/alpha/volunteer/)

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
* Run `cp .env.sample .env`. Open the .env file and adjust environment
  variables as appropriate.
* Run `bundle exec foreman start` to start unicorn & postgres.   
* Visit localhost:8080 to view the site.
