# frozen_string_literal: true

require 'rails_helper'
require_relative 'users/_login_examples'
require_relative 'users/_create_examples'

RSpec.describe 'Users Management', type: :request do
  it_behaves_like 'users_login_examples'
  it_behaves_like 'users_create_examples'
end
