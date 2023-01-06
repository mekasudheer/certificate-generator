# frozen_string_literal: true

require 'test_helper'

class BaseControllerTest < ActionDispatch::IntegrationTest
  test 'can respond with certificate_expiry_date' do
    get 'https://localhost:3000/base/search'
    assert_includes(Rails.configuration.middleware.middlewares, CertExpiry::Response)
    assert JSON.parse(@response.body)['certificate_expiry_date']
  end
end
