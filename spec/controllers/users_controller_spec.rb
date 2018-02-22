# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#GET new' do
    it 'assigns a new user' do
      get :new

      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe '#POST create' do
    it 'creates a new user account' do
      expect do
        post :create, params: { user: attributes_for(:user) }

        expect(response).to have_http_status(:ok)
      end.to change { User.count }.by(1)
    end

    it 'renders the form again when the user is invalid' do
      expect do
        post :create, params: { user: attributes_for(:user, email: '') }

        expect(response).to render_template('new')
      end.not_to change { User.count }
    end
  end
end
