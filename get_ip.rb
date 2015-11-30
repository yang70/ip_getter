#!/usr/bin/env ruby
require 'capybara'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist

class GetIp
  include Capybara::DSL

  def scrape
    visit('http://www.bing.com')
    fill_in 'sb_form_q', with: 'what is my ip'
    find('#sb_form_go').click
    ip = find('.b_focusTextMedium').text
    ip_hash = { ip: ip,
                time: Time.now
    }
  end

  def save(info)
    file = '/Users/yang70/Dropbox/ip.txt'
    File.open file, 'w' do |f|
      f.write info
    end
  end
end

n = GetIp.new

new_ip = n.scrape
puts new_ip
n.save new_ip
    
