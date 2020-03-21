CurrentAgent.delete_all
CurrentLocation.delete_all
CurrentTemperament.delete_all
CurrentNaturalGuild.delete_all
User.delete_all
Credential.delete_all
Agent.delete_all
EmailAddress.delete_all
Location.delete_all
Temperament.delete_all
NaturalGuild.delete_all
Message.delete_all
Password.delete_all

email_addresses = EmailAddress.create([
  { email: Faker::Internet.email },
  { email: Faker::Internet.email },
  { email: Faker::Internet.email },
  { email: Faker::Internet.email },
  { email: Faker::Internet.email },
  { email: Faker::Internet.email },
  { email: Faker::Internet.email },
  { email: Faker::Internet.email },
  { email: Faker::Internet.email },
  { email: Faker::Internet.email }
])

Agent.create email_addresses.map{ |email_address| { name: Faker::Company.name, email_address: email_address } }

Location.create([
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet }
])

Temperament.create([
  { name: Faker::Space.moon },
  { name: Faker::Space.moon },
  { name: Faker::Space.moon },
  { name: Faker::Space.moon }
])

NaturalGuild.create([
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet },
  { name: Faker::Space.planet }
])
