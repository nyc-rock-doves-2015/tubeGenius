class CallbacksController < ApplicationController
 
  def index
    p request.env['omniauth.auth']['info']
    #This is just printing to the console. You would create / log in a user here
  end
  
end