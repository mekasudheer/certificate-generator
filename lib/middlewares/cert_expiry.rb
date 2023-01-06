# frozen_string_literal: true

module CertExpiry
  require 'rack'

  class Response
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      new_response = insert_expiry_date(response.body)
      [status, headers, [new_response]]
    end

    def insert_expiry_date(body)
      body = JSON.parse(body)
      raw = File.read 'certs/certificate.pem'
      certificate = OpenSSL::X509::Certificate.new raw
      body[:certificate_expiry_date] = certificate.not_after.to_date.strftime('%Y-%m-%d')
      body.to_json
    end
  end
end
