require 'rails_helper'
require 'rake'

describe 'programs:import_podcast_links' do
  context 'when parsed file is not empty' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) do
        [
            {number: 1, data: 'xxx'},
            {number: 2, data: 'xxx'}
        ]
      end
    end

    context 'when all records have links' do
      let!(:program_with_link) {FactoryGirl.create(:program_info, id: 1, link_to_podcast: 'some_link')}

      it 'should run without errors' do
        expect {task.execute}.not_to raise_error
      end

      it 'should log to stdout' do
        expect {task.execute}.to output(" Finished! Updated 0 records.\n").to_stdout
      end
    end

    context 'when some records have empty links' do
      let!(:program_without_link) {FactoryGirl.create(:program_info, id: 1, link_to_podcast: nil)}

      it 'should run without errors' do
        expect {task.execute}.not_to raise_error
      end

      it 'should update one record' do
        expect {task.execute}.to output(" Finished! Updated 1 record.\n").to_stdout
      end
    end
  end

  context 'when parsed file is empty' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) {[]}
    end

    it 'should not update any records' do
      expect {task.execute}.to output(" Finished! Updated 0 records.\n").to_stdout
    end
  end

  context 'when parsed file does not have matching results' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) {[{number: 100, link: 'xxx'}]}
    end

    it 'should not update any records' do
      expect {task.execute}.to output(" Finished! Updated 0 records.\n").to_stdout
    end
  end
end

describe 'programs:update_program_tags' do
  let!(:program1) {FactoryGirl.create(:program_infos, id: 1)}
  let!(:program2) {FactoryGirl.create(:program_infos, id: 2)}

  let!(:tag1) {FactoryGirl.create(:tag, id: 1)}
  let!(:tag2) {FactoryGirl.create(:tag, id: 2)}
  let!(:tag3) {FactoryGirl.create(:tag, id: 3)}

  context 'when all tags are valid' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) do
        [
            {number: 1, data: '1,2,3'},
            {number: 2, data: '3'}
        ]
      end
    end

    it 'changes ProgramTagCount' do
      expect {task.execute}.to change {ProgramTag.count}.from(0).to(4)
    end
  end

  context 'when trying to reference non-existent tag' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) do
        [
            {number: 1, data: '9999'},
            {number: 2, data: '3'}
        ]
      end
    end

    it 'expect to raise an error' do
      expect {task.execute}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'when given tag is already in the database' do
    before do
      allow_any_instance_of(Object).to receive(:parse_file) do
        [
            {number: 1, data: '1'},
            {number: 2, data: '3'}
        ]
      end
      FactoryGirl.create(:program_tag, program_id: program1.id, tag_id: tag1.id)
      FactoryGirl.create(:program_tag, program_id: program2.id, tag_id: tag3.id)
    end

    it 'expect to raise an error' do
      expect {task.execute}.not_to change {ProgramTag.count}
      expect {task.execute}.to output(/Finished! Updated 0 records.\n/).to_stdout
      expect {task.execute}.to output(
         /Skipping record: program_info number: 1, tag: 1. Already in db\n/).to_stdout
      expect {task.execute}.to output(
         /Skipping record: program_info number: 2, tag: 3. Already in db\n/).to_stdout
    end
  end
end
