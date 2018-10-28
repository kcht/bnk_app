require 'rails_helper'
include SessionsHelper

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

  describe 'edit' do
    subject {get :edit, params: {id: 1}}
    let!(:program_infos) {FactoryGirl.create(:program_infos, id: 1)}

    context 'when user is not logged in' do
      it 'redirects to index' do
        expect(subject).to redirect_to :programs
      end
    end

    context 'when user is logged in' do
      before do
        log_in user
      end

      context 'when user is admin' do
        let(:user) {FactoryGirl.create(:user, :admin)}

        it {is_expected.to render_template 'edit'}
      end

      context 'when user is not admin' do
        let(:user) {FactoryGirl.create(:user, :not_admin)}

        it {is_expected.to redirect_to :programs }
      end
    end
  end

  describe 'show' do
    subject {get :show, params: {id: 1}}
    let!(:program_infos) {FactoryGirl.create(:program_infos, id: 1)}

    context 'when user is not logged in' do
      it { is_expected.to render_template 'show' }
    end

    context 'when user is logged in' do
      before do
        log_in user
      end

      context 'when user is admin' do
        let(:user) {FactoryGirl.create(:user, :admin)}

        it {is_expected.to render_template 'show'}
      end

      context 'when user is not admin' do
        let(:user) {FactoryGirl.create(:user, :not_admin)}

        it {is_expected.to render_template 'show' }
      end
    end
  end

  describe '#index_all' do
    subject { get :index_all }

    before do
      log_in user
    end
    context 'when user is admin' do
      let(:user) {FactoryGirl.create(:user, :admin) }

      it {is_expected.to render_template 'index'}
    end

    context 'when user is not admin' do
      let(:user) {FactoryGirl.create(:user, :not_admin)}

      it {is_expected.to redirect_to :programs}
    end
  end
end
