class PagesController < ApplicationController
    def home 
        if user_signed_in?
            render 'home'
          else
            render 'home_logout'
          end
    end
end
