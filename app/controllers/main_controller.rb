class MainController < ApplicationController
  def index
    @artists = Artist.all.order('score DESC').limit(20)
  end
end
