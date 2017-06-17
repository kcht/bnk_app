namespace :programs do
  FILE_WITH_LINKS = 'db/bnk_data/links_to_podcasts'

  desc "Add links to podcasasts"
  task import_podcast_links: :environment do
    links = parse_file(FILE_WITH_LINKS)

    count_updated = 0
    ActiveRecord::Base.transaction do
      links.each do |link|
        number = link[:number]
        programs = Program.where(number: number)
        programs.each do |program|
          if should_update_program?(program, link[:link])
            program.update!(link_to_podcast: link[:link])
            count_updated +=1
            end
        end
      end
    end

    puts " Finished! Updated #{count_updated} record(s)."
  end
end

def parse_file(file)
  file = File.new(file).readlines
  file.map { |link| {number: link.split('.',2)[0]&.squish, link: link.split('.',2)[1]&.squish} }
end

def should_update_program?(program, link)
  link && !program.link_to_podcast
end