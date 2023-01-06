# frozen_string_literal: true

require 'openssl'
desc 'Create Self Signed Certificate'
task :create_certificate, [:days, :domain_name] do |_t, args|
  key = OpenSSL::PKey::RSA.new 4096
  domain_name = args[:domain_name] || 'localhost'
  days = args[:days] || 365
  name = OpenSSL::X509::Name.parse '/CN=nobody'

  cert = OpenSSL::X509::Certificate.new

  cert.version = 2

  cert.serial = 0

  cert.not_before = Time.now

  cert.not_after = Time.now + days.to_i.days

  cert.public_key = key.public_key

  cert.subject = name

  cert.issuer = name

  cert.sign key, OpenSSL::Digest.new('SHA256')

  open './tmp/certs/certificate.pem', 'w' do |io| io.write cert.to_pem end

  open './tmp/certs/privatekey.pem', 'w' do |io| io.write key.to_pem end

  puts File.read('./tmp/certs/certificate.pem')
  puts File.read('./tmp/certs/privatekey.pem')
end
