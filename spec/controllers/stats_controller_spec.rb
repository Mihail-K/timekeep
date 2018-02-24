# frozen_string_literal: true
require 'rails_helper'

RSpec.describe StatsController, type: :controller do
  let(:user) { create(:user) }

  describe '#GET index' do
    it "assigns the user's stats" do
      stats = double('Stats')
      allow(Event).to receive(:longest_duration).and_return(stats)

      get :index, params: { user_id: user.id }
      expect(assigns(:stats)).to be(stats)
    end
  end
end
