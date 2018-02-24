# frozen_string_literal: true
# == Schema Information
#
# Table name: events
#
#  id          :uuid             not null, primary key
#  user_id     :uuid             not null
#  date        :date             not null
#  start_time  :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE), not null
#  deleted_at  :datetime
#  end_time    :string
#  duration    :integer
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

  describe '#GET new' do
    it 'assigns a new event with a default date and start time' do
      Time.use_zone(user.time_zone) do
        get :new, session: { token: session.token }

        expect(assigns(:event)).to be_a_new(Event)
        expect(assigns(:event).date).to eq(Date.current)
        expect(assigns(:event).start_time).to eq(Time.current.strftime('%R'))
      end
    end
  end

  describe '#POST create' do
    it 'creates a new event' do
      expect do
        post :create, params: { event: attributes_for(:event) }, session: { token: session.token }

        expect(response).to redirect_to(user_events_url(user, date: Date.current.iso8601))
      end.to change { Event.count }.by(1)
    end

    it 'renders the new event form when the event is invalid' do
      expect do
        post :create, params: { event: attributes_for(:event, date: nil) }, session: { token: session.token }

        expect(response).to render_template('new')
      end.not_to change { Event.count }
    end
  end

  describe '#DELETE destroy' do
    let!(:event) { create(:event, user: user) }

    it 'marks the requested event as deleted' do
      expect do
        delete :destroy, params: { id: event.id }, session: { token: session.token }

        expect(response).to redirect_to(user_events_url(user, date: event.date))
      end.to change { event.reload.deleted }.to(true)
    end
  end
end
