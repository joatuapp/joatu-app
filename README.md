README
======

About the Project
-----------------
The Jack Of All Trade Universe is an online marketplace for self-organized exchanges. The JoatUnit is a currency that is generated to promote community activities such as planting community gardens or teaching classes. More information can be found at [joatu.com](http://www.joatu.com)

Contributions
-------------
Contributions are welcome. If you wish to help with the project, please consider [donating to our crowdfunding campaign](http://love.joatu.com) or [contact us about volunteering](http://joatu.com/alpha/volunteer/)

Gettig Started
--------------
To run the code in a development environment, follow these steps. (NOTE: These steps assume that you have ruby 2.1.0 installed, as well as Postgres 9.3+ with the Postgis extension.)
* Clone the repository 
* Change to the repository root: `cd joatu-app`
* Run `bundle install`
* Run `thor joatu setup`. This will configure the database.
* Run `foreman start` to start unicorn & postgres.   
* Visit localhost:8080 to view the site.
