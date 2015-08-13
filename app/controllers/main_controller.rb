class MainController < ApplicationController
  def index
    @artists = Artist.all.order('score DESC').limit(10)
  end
end
