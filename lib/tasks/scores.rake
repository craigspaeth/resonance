namespace :scores do
  desc 'refresh scores'
  task refresh: :environment do
    client = Mongo::Client.new(ENV['mongo_url'])
    trending_artists = client[:artists].find("published_artworks_count" => { "$gt" => 10 }, ).sort(updated_at: :desc).limit(100)

    # name character varying NOT NULL,
    # artsy_id character varying NOT NULL,
    # slug character varying NOT NULL,
    # thumbnail character varying,
    # page_views integer,
    # follows integer,
    # score integer DEFAULT 0 NOT NULL,
    trending_artists.each do |trend|
      puts trend.inspect
      slug = trend['_slugs'].first
      artist = Artist.where(slug: slug).first_or_initialize.tap do |a|
        a.name = trend['display_name']
        a.artsy_id = trend['_id'].to_s
        a.thumbnail = trend['image_urls']['square']
        a.page_views = SecureRandom.random_number(10000)
        a.follows = trend['follow_count'] || 0
      end
      artist.calculate_score!
    end
  end
end
