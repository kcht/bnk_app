namespace :programs do
  FILE_WITH_LINKS_TO_PODCASTS = 'db/bnk_data/links_to_podcasts'
  FILE_WITH_PROGRAM_TAG_INFO = 'db/bnk_data/initial_tags'

  desc "Add links to podcasasts"
  task import_podcast_links: :environment do
    links = parse_file(FILE_WITH_LINKS_TO_PODCASTS)

    count_updated = 0
    ActiveRecord::Base.transaction do
      links.each do |link|
        number = link[:number]
        programs = Program.where(number: number)
        programs.each do |program|
          if should_update_podcast_link_for_program?(program, link[:data])
            program.update!(link_to_podcast: link[:data])
            count_updated +=1
          end
        end
      end
    end

    puts " Finished! Updated #{count_updated} #{"record".pluralize(count_updated)}."
  end

  desc "Update tags for programs based on file info"
  task update_tags: :environment do
    info = parse_file(FILE_WITH_PROGRAM_TAG_INFO)
    ActiveRecord::Base.transaction do
      info.each do |info|
        program = Program.where(number: info[:number]).first
        next unless program
        tag_codes = info[:data]&.split(',')&.map(&:squish)
        tag_codes&.each do |tag_code|
          puts "Analyzing program #{program.id}"
          tag = Tag.find_by!(code: tag_code)
          puts "Found tag with code #{tag_code}" if tag.present?

          ProgramTag.where(tag_id: tag.id, program_id: program.id).first_or_create!
        end
      end
      puts " Finished! Updated program tags."
    end
  end

  def parse_file(file)
    file = File.new(file).readlines
    file.map {|link| {number: link.split(':', 2)[0]&.squish, data: link.split(':', 2)[1]&.squish}}
  end

  def should_update_podcast_link_for_program?(program, link)
    link && !program.link_to_podcast
  end

  def is_program_tag_already_in_db?(program_id, tag_id)
    ProgramTag.where(program_id: program_id, tag_id: tag_id).empty?
  end
end