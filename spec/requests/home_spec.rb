# frozen_string_literal: true

require 'rails_helper'
# require_relative 'home/_admin_examples'
require_relative 'home/_unauthenticated_examples'

RSpec.describe 'Home Management', type: :request do
  # it_behaves_like 'home_admin_examples'
  it_behaves_like 'home_unauthenticated_examples'
end
