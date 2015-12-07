#!/usr/bin/env ruby
require 'capybara'
require 'capybara/poltergeist'
require 'json'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.default_driver = :poltergeist

class GetIp
  include Capybara::DSL

  def scrape
    puts "scraping now..."
    visit('http://ipaddress.com')
    ip = find('td strong').text
    puts "IP address set to: " + ip
    ip_object = { 'ip' => ip,
                'time' => Time.now
    }.to_json
  end

  def save(info)
    # Fill in your save location path ie. '~/Dropbox/'
    file = '<PATH TO SAVE LOCATION>' + 'ip.json'
    File.open file, 'w' do |f|
      f.write info
    end
  end
end

n = GetIp.new

new_ip = n.scrape

n.save new_ip

puts "get_ip done"
