class MainController < ApplicationController
  def index
    @artists = Artist.all.order('page_views DESC')
  end
end
