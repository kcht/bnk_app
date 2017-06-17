require 'rails_helper'
require 'rake'

describe 'programs:import_podcast_links' do
  let(:program_without_link) { FactoryGirl.create(:program, id: 11, link_to_podcast: nil) }
  let(:program_with_link){ FactoryGirl.create(:program, id: 23,link_to_podcast: 'some_link') }

  describe 'Initialization' do

    it 'should initialize fields to zero' do


      task.execute

    end
  end


end
