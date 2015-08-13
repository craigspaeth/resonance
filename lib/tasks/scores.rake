namespace :scores do
  desc 'refresh scores'
  task refresh: :environment do
    client = Mongo::Client.new(ENV['mongo_url'])
    slugs = ['andy-warhol', 'lorna-simpson']

    # name character varying NOT NULL,
    # artsy_id character varying NOT NULL,
    # slug character varying NOT NULL,
    # thumbnail character varying,
    # page_views integer,
    # follows integer,
    # score integer DEFAULT 0 NOT NULL,
    slugs.each do |slug|
      gravity_artist = client[:artists].find(_slugs: slug).first
      gravity_artist['display_name'] = nil if gravity_artist['display_name'].blank?
      artist = Artist.where(slug: slug).first_or_initialize.tap do |a|
        a.name = gravity_artist['display_name'] || "#{gravity_artist['first']} #{gravity_artist['last']}"
        a.artsy_id = gravity_artist['_id'].to_s
        a.thumbnail = gravity_artist['image_urls']['square']
        a.page_views = SecureRandom.random_number(10_000)
        a.follows = gravity_artist['follow_count'] || 0
      end
      artist.calculate_score!
    end
  end
end
