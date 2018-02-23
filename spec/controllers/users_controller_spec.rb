# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :citext           not null
#  password_digest :string           not null
#  first_name      :string
#  last_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#GET new' do
    it 'assigns a new user' do
      get :new

      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe '#POST create' do
    it 'creates a new user account and a new session' do
      expect do
        post :create, params: { user: attributes_for(:user) }

        expect(response).to redirect_to(user_events_url(User.last))
      end.to change { User.count }.by(1)
        .and change { Session.count }.by(1)
    end

    it 'renders the form again when the user is invalid' do
      expect do
        post :create, params: { user: attributes_for(:user, email: '') }

        expect(response).to render_template('new')
      end.not_to change { User.count }
    end
  end
end
