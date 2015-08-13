if Rails.env.development?
  Artist.create!(  
    name: 'Andy Warhol',
    artsy_id: '4d8b92b34eb68a1b2c0003f4',
    slug: 'andy-warhol',
    thumbnail: 'https://d32dm0rphc51dk.cloudfront.net/PFufT6nMKNwLOpPEezf4Ww/square.jpg',
    page_views: 5000,
    follows: 17599
  )

  Artist.create!(
    name: 'Lorna Simpson',
    artsy_id: '4e25a7c294419300010084f2',
    slug: 'lorna-simpson',
    thumbnail: 'https://d32dm0rphc51dk.cloudfront.net/fzAhcb3A2c93XXUelyvizg/square.jpg',
    page_views: 3000,
    follows: 785
  )
end