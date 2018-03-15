# frozen_string_literal: true
# == Schema Information
#
# Table name: events
#
#  id               :uuid             not null, primary key
#  user_id          :uuid             not null
#  date             :date             not null
#  start_time       :string           not null
#  description      :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted          :boolean          default(FALSE), not null
#  deleted_at       :datetime
#  end_time         :string
#  duration         :integer
#  html_description :text             not null
#  text_description :text             not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { create(:user) }
  let(:session) { create(:session, user: user) }

  before(:each) do
    cookies.encrypted[:session_token] = session.token
  end

  describe '#GET new' do
    it 'assigns a new event with a default date and start time' do
      Time.use_zone(user.time_zone) do
        get :new

        expect(assigns(:event)).to be_a_new(Event)
        expect(assigns(:event).date).to eq(Date.current)
        expect(assigns(:event).start_time).to eq(Time.current.strftime('%R'))
      end
    end
  end

  describe '#POST create' do
    it 'creates a new event' do
      expect do
        post :create, params: { event: attributes_for(:event) }

        expect(response).to redirect_to(user_events_url(user, date: Date.current.iso8601))
      end.to change { Event.count }.by(1)
    end

    it 'renders the new event form when the event is invalid' do
      expect do
        post :create, params: { event: attributes_for(:event, date: nil) }

        expect(response).to render_template('new')
      end.not_to change { Event.count }
    end
  end

  describe '#PATCH close' do
    let(:event) { create(:event, user: user) }

    it 'sets the end time on the requested event' do
      expect do
        patch :close, params: { id: event.id }

        params = { date: Date.current.iso8601, anchor: "event-#{event.id}" }
        expect(response).to redirect_to(user_events_url(user, params))
      end.to change { event.reload.end_time }
    end
  end

  describe '#DELETE destroy' do
    let!(:event) { create(:event, user: user) }

    it 'marks the requested event as deleted' do
      expect do
        delete :destroy, params: { id: event.id }

        expect(response).to redirect_to(user_events_url(user, date: event.date))
      end.to change { event.reload.deleted }.to(true)
    end
  end
end
