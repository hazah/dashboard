ActionText::RichText.delete_all
Message.delete_all

CurrentConversation.delete_all
CurrentProfile.delete_all
CurrentContext.delete_all
CurrentCategoryChild.delete_all
CurrentCategory.delete_all
CurrentNetworkMode.delete_all

Conversation.delete_all
AggregateProfileDetail.all.each { |d| d.children = [] }
AggregateProfileDetail.delete_all

Context.delete_all
Category.delete_all

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

NetworkMode.delete_all

ProfileMode.create
ConversationMode.create

categories = {
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
    'Sentient Machine'
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
  'Sentient Machine': []
}

Category.create categories.map{ |g, cs| { name: g, children: Category.create(cs.map{ |c| { name: c } }) } }

locations = ["Embassy", "Great Bonfire", "Crystal Gardens", "Field Research Lab"]
Context.create locations.map{ |l| { name: l } }

# profile_data = (1..12).map{|v| [ Faker::Company.name, Faker::Internet.email ]}
# profile_data = profile_data.map{|k, v| { name_model_attributes: { name: k }, email_model_attributes: { email: v } } }
# BasicProfile.create profile_data.map{|v| { detail_attributes: v, human_attributes: { detail_attributes: { id: "" }}}}
