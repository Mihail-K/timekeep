# frozen_string_literal: true
# == Schema Information
#
# Table name: events
#
#  id          :uuid             not null, primary key
#  user_id     :uuid             not null
#  date        :date             not null
#  time        :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
end
