# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create initial Communities:
community_data = [
  {
    name: "Hastings Park",
    location: "POINT(-123.036971 49.286065)",
  },
]

communities = community_data.map {|c| Community.create! c }

# Create initial admins:
unless initial_password = ENV['seed_initial_password']
  if Rails.env.development?
    initial_password = 'foobarbash'
  else
    raise "Environment variable 'seed_initial_password' must be set to run seeds in a non-development environment!"
  end
end

admin_data = [
  {
    username: 'awillemsma',
    email: 'alex@undergroundwebdevelopment.com',
    password: initial_password,
    primary_community_id: communities.first.id,
    given_name: 'Alex',
    surname: 'Willemsma',
    birth_date: Date.new(1989, 07, 28),
    sex: 'male',
    current_location: "POINT(-123.044859 49.282964)",
    postal_code: 'V5K1W3',
    neighbourhood: 'Hastings-Sunrise',
    city: 'Vancouver',
    province: 'British Columnbia',
    country: 'Canada',
  }
]

admin_data.each do |a|
  a[:is_admin] = true
  admin = UserWithDetail.new a
  admin.user.email_confirmation = a[:email]
  admin.confirmed_at = DateTime.now
  admin.save!
end
