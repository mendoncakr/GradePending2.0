require 'spec_helper'
require 'rails_helper'
require 'shoulda/matchers'
RSpec.describe Inspection, :type => :model do 
  it {should belong_to(:restaurant)}
end
