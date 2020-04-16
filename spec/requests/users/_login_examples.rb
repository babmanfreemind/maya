# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'users_login_examples' do
	describe '#login', :type => :request do
		let(:params) do
			{
				user: {
					email: email,
					password: password
				}
			}
		end
		let(:response_hash) { JSON.parse(response.body) }
		context 'when user exists' do
			let(:existing_user_password) { "azerty123" }
			let!(:existing_user) { FactoryBot.create(:user, email: email, password: existing_user_password, password_confirmation: existing_user_password) }
			before do
				headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
				post '/users/sign_in', params: params.to_json, headers: headers 
			end
			
			context 'when password match' do
				let(:email) { "bob@bob.com" }
				let(:password) { existing_user_password }

				it { expect(response.cookies['_maya_session']).to_not be_nil }
				it { expect(response.status).to eq(201) }
			end

			context 'when password does not match' do
				let(:email) { "bob@bob.com" }
				let(:password) { "123456789" }
				it { expect(response.status).to eq(401) }
				it { expect(response_hash['error']).to eq("Invalid Email or password.") }
			end
		end

		context 'when user does not exists' do
			before do
				headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
				post '/users/sign_in', params: params.to_json, headers: headers 
			end
			let(:email) { "random_string" }
			let(:password) { "random_string" }
			it { expect(response.status).to eq(401) }
			it { expect(response_hash['error']).to eq("Invalid Email or password.") }
		end
	end
end