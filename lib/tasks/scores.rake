namespace :scores do
  desc 'refresh scores'
  task refresh: :environment do
    client = Mongo::Client.new(ENV['mongo_url'])
    conn = PG.connect(host: ENV['redshift_host'], 
      port: ENV['redshift_port'],
      user: ENV['redshift_user'],
      password: ENV['redshift_password'],
      dbname: ENV['redshift_dbname']
      )
    sql = <<ENDSQL
WITH recent_week AS
(
  SELECT a.name AS name,
         COUNT(*) AS N
  FROM follow_artists f
    LEFT JOIN artists a ON f.artist_id = a.id
  WHERE f.created_at > dateadd (week,-1,GETDATE ())
  AND a.follow_count > 500
  GROUP BY name
),
--FOLLOW ARTISTS
 earlier_weeks AS
(SELECT name,
       AVG(N::float) as avg_,
       stddev(N::float) AS stddev_
FROM (SELECT a.name as name,
             TO_CHAR(DATE_TRUNC('week',CONVERT_TIMEZONE ('UTC','America/New_York',f.created_at)),'YYYY-MM-DD') AS "week",
             COUNT(*) AS N
      FROM follow_artists f
        LEFT JOIN artists a ON f.artist_id = a.id
      WHERE f.created_at > dateadd (MONTH,-3,GETDATE ())
      AND a.follow_count > 500
      GROUP BY name,
               week
      ORDER BY name ASC)
GROUP BY name)
SELECT art.slug, art.name, art.follow_count, 
       (recent_week.N - earlier_weeks.avg_) / stddev_ z_score
from recent_week
JOIN earlier_weeks on recent_week.name = earlier_weeks.name
JOIN artists art on recent_week.name = art.name
WHERE stddev_ <> 0
ORDER BY z_score DESC
ENDSQL

    conn.exec(sql) do |result|
      result.each do |row|
        slug = row['slug']
        gravity_artist = client[:artists].find(_slugs: slug).first
        artist = Artist.where(slug: slug).first_or_initialize.tap do |a|
          a.name = row['name']
          a.artsy_id = gravity_artist['_id'].to_s
          a.thumbnail = gravity_artist['image_urls']['square']
          a.page_views = 0
          a.follows = row['follow_count']
          a.score = row['z_score'].to_f * 2000
        end
        artist.save!
      end
    end
  end
end
