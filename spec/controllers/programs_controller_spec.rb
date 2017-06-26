require 'rails_helper'

RSpec.describe ProgramsController, type: :controller do

  describe '#index_tags' do
    subject {get :index_tags, params: {tag_id: tag_id}}

    context 'when requesting existing tag' do
      let(:tag_id) {1}

      it 'is success' do
        subject

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'when requesting tag with nonexistent id' do
      let(:tag_id) {9999}

      it 'route is not found' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'when  given id is nil' do
      let(:tag_id) {nil}

      it 'raises an error' do
        expect {subject}.to raise_error ActionController::UrlGenerationError
      end
    end
  end
end
