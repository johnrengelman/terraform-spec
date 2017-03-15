require 'terraform/utils'
require 'awspec'

state_file = attribute 'terraform_state', ''
state = Terraform::Utils.loadState(File.expand_path(state_file))

control 'default' do
  
end
