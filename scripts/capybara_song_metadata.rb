require 'capybara'

session = Capybara::Session.new(:selenium)
session.visit('http://www.google.com')

file = File.new('db/bnk_data/bnk_044_perseidy')
file.each_line do |line|

  search_query= line.split('.')[-1]


  session.fill_in('lst-ib', with: search_query)
  session.find('#lst-ib').native.send_keys(:return)

  if session.has_css?('.kno-fb-ctx', text: 'Album')
    tag = session.find('.kno-fb-ctx', text: 'Album')
    album_title = tag.find('.kno-fv').find('.fl').text


    tag = session.find('.kno-fb-ctx', text: 'Data wydania')
    album_date = tag.find('.kno-fv').text

    puts string = "#{line}: (#{album_title}, #{album_date})"
  else
    puts line + ' - not found'
  end

end

