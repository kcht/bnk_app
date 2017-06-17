require 'rails_helper'
require 'rake'

describe 'programs:import_podcast_links' do
  context 'when parsed file is not empty' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) do
        [
            {number: 1, link: 'xxx'},
            {number: 2, link: 'xxx'}
        ]
      end
    end

    context 'when all records have links' do
      let!(:program_with_link) { FactoryGirl.create(:program, id: 1, link_to_podcast: 'some_link') }

      it 'should run without errors' do
        expect { task.execute }.not_to raise_error
      end

      it 'should log to stdout' do
        expect { task.execute }.to output(" Finished! Updated 0 record(s).\n").to_stdout
      end
    end

    context 'when some records have empty links' do
      let!(:program_without_link) { FactoryGirl.create(:program, id: 1, link_to_podcast: nil) }

      it 'should run without errors' do
        expect { task.execute }.not_to raise_error
      end

      it 'should update one record' do
        expect { task.execute }.to output(" Finished! Updated 1 record(s).\n").to_stdout
      end
    end
  end

  context 'when parsed file is empty' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) { [] }
    end

    it 'should not update any records' do
      expect { task.execute }.to output(" Finished! Updated 0 record(s).\n").to_stdout
    end
  end

  context 'when parsed file does not have matching results' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) { [{number: 100, link: 'xxx'}] }
    end

    it 'should not update any records' do
      expect { task.execute }.to output(" Finished! Updated 0 record(s).\n").to_stdout
    end
  end
end
