# Using a custom mailer also lets us customize the emails
# that are sent. Specifically we _need_ to customize the
# email confirmation email, as the URL needs to point to
# the frontend app, not the API directly.

class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
end
