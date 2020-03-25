Message.delete_all

CurrentBasicProfile.delete_all
CurrentLocation.delete_all
CurrentConcernArea.delete_all
CurrentNaturalGuild.delete_all

Location.delete_all
ConcernArea.delete_all
NaturalGuild.delete_all

User.delete_all
PasswordCredentialDatum.delete_all
Credential.delete_all
BasicProfileDetail.delete_all
Profile.delete_all
Password.delete_all
Email.delete_all
Name.delete_all
HumanDetail.delete_all
Agent.delete_all

natural_guilds = {
  'Education': [
    'Education',
    'Immunity',
    'Environment',
    'Technology',
    'Data',
    'Economy',
    'Industy',
    'Diplomacy',
    'Trade',
    'Computing',
    'Synthetic Neural Computing',
    'Santient Machine'
  ],
  'Immunity': [
    'Hygiene',
    'Nutrition',
    'Rest',
    'Fitness',
    'Focus',
    'Restoration',
    'Preservation'
  ],
  'Environment': [
    'Inner',
    'Outer'
  ],
  'Technology': [],
  'Data': [],
  'Economy': [],
  'Industy': [],
  'Diplomacy': [],
  'Trade': [],
  'Computing': [],
  'Synthetic Neural Computing': [],
  'Santient Machine': []
}

NaturalGuild.create natural_guilds.map{ |g, cs| { name: g, concern_areas: ConcernArea.create(cs.map{ |c| { name: c } }) } }

locations = ["Embassy", "Great Bonfire", "Crystal Gardens", "Field Research Lab"]
Location.create locations.map{ |l| { name: l } }

profile_data = (1..12).map{|v| [ Faker::Company.name, Faker::Internet.email ]}
profile_data = profile_data.map{|k, v| { name_model_attributes: { name: k }, email_model_attributes: { email: v } } }
BasicProfile.create profile_data.map{|v| { detail_attributes: v, human_attributes: { detail_attributes: { id: "" }}}}
