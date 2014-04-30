require 'spec_helper'
# Rename this file to classname_spec.rb
# Check other boxen modules for examples
# or read http://rspec-puppet.com/tutorial/
describe 'sshconfig' do
  it do
    should contain_class('sshconfig')
  end
end
