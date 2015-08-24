class HomeController < ApplicationController

  def index
  	
  end

    def bestsellers
    Book.all.limit(5)
    end

end
