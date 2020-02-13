# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'home_unauthenticated_examples' do
	describe '#index' do
		context 'when user is not authenticated' do
			before do
				get "/"
			end
			it { expect(response.status).to eq(200) }
		end
	end
end