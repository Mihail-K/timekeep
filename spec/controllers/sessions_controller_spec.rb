# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#GET new' do
    it 'assigns a new session' do
      get :new

      expect(assigns(:session)).to be_a_new(Session)
    end
  end

  describe '#POST create' do
    let(:user) { create(:user) }

    it 'creates a new session' do
      expect do
        post :create, params: { session: { email: user.email, password: user.password } }

        expect(response).to have_http_status :ok
      end.to change { Session.count }.by(1)
    end

    it 'renders the form again when the session is invalid' do
      expect do
        post :create, params: { session: { email: user.email, password: 'wrong' } }

        expect(response).to render_template('new')
      end.not_to change { Session.count }
    end
  end

  describe '#DELETE destroy' do
    let!(:session) { create(:session) }

    it 'terminates the session and redirects to login' do
      expect do
        delete :destroy, session: { token: session.token }

        expect(response).to redirect_to(new_session_url)
      end.to change { Session.count }.by(-1)
    end
  end
end
