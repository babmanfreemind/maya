# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'users_create_examples' do
	describe '#create', :type => :request do
		let(:params) do
			{
				user: {
					email: email,
					password: password,
					password_confirmation: password_confirmation
				}
			}
		end
		let(:response_hash) { JSON.parse(response.body) }
		
		context 'when user does not exists' do
			before do
				headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
				post "/users", params: params.to_json, headers: headers
			end
			context 'when password and password_confirmation match' do
				let(:email) { 'bob@bob.com' } 
				let(:password) { 'azerty' }
				let(:password_confirmation) { 'azerty' }
				
				it { expect(response.status).to eq(200) }
				it { expect(response_hash['email']).to eq("bob@bob.com") }
				it { expect(User.count).to eq(1) }
			end

			context 'when password and password_confirmation does not match' do
				let(:email) { 'bob@bob.com' } 
				let(:password) { 'azerty' }
				let(:password_confirmation) { 'azerty123' }

				it { expect(response.status).to eq(400) }
				it { expect(response_hash['errors'][0]['detail']['password_confirmation'][0]).to eq('doesn\'t match Password') }
				it { expect(User.count).to eq(0) }
			end
		end
		context 'when email is taken' do
			let!(:existing_user) { FactoryBot.create(:user, email: email) }
			let(:email) { "email@email.com" }
			let(:password) { "password" }
			let(:password_confirmation) { "password" }

			before do
				headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
				post "/users", params: params.to_json, headers: headers
			end

			it { expect(response.status).to eq(400) }
			it { expect(response_hash['errors'][0]['detail']["email"][0]).to eq("has already been taken") }
		end
	end
end