require 'rails_helper'

RSpec.describe User, type: :model do
  subject {user.save}

  describe '#save' do
    context 'with valid user' do
      let(:user) do
        described_class.new(name: 'Kate Cha', email: 'KCH@kch.pl',
                            password: 'testtest', password_confirmation: 'testtest')
      end

      it 'changes email to downcase' do
        subject
        expect(User.last.email).to eq('kch@kch.pl')
      end

      it 'saves user' do

      end
    end

    context 'when attributes are invalid' do
      context 'when email is missing' do
        let(:user) do
          described_class.new(name: 'Kate Cha', email: nil,
                              password: 'testtest', password_confirmation: 'testtest')
        end

        it 'does not save user' do
          expect(subject).to be_falsey
        end
      end

      context 'when password is too short' do
        let(:user) do
          described_class.new(name: 'Kate Cha', email: 'kch@kch.pl',
                              password: 'a', password_confirmation: 'a')
      end
        it 'does not save user' do
          expect(subject).to be_falsey
        end
      end

      context 'when password is empty' do
        let(:user) do
          described_class.new(name: 'Kate Cha', email: 'kch@kch.pl',
                              password: nil, password_confirmation: nil)
        end
        it 'does not save user' do
          expect(subject).to be_falsey
        end
      end
      context 'when passwords don\'t match' do
        let(:user) do
          described_class.new(name: 'Kate Cha', email: 'kch@kch.pl',
                              password: 'onepassword', password_confirmation: 'other')
        end
        it 'does not save user' do
          expect(subject).to be_falsey
        end
      end
    end

    context 'when trying to save duplicate user' do
      let(:user) do
        described_class.new(name: 'Kate Cha', email: 'kch@kch.pl',
                            password: 'password', password_confirmation: 'password')
      end

      let(:user2) do
        user.dup
      end

      it 'does not save user' do
        user2.save
        expect(subject).to be_falsey
      end
    end
  end

  describe '.authenticated?' do
    subject { user.authenticated?('') }

    let(:user) { FactoryGirl.create(:user, :without_remember_digest)}
    context 'when token digest is nil for user' do

      it { is_expected.to be false}
    end
  end
end
