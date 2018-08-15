class AdpClientController < ApplicationController

  def connect
    connection = Adp.client_connection
    connection.connect()
    if connection.is_connected_indicator?
      session[:client_credential] = connection
    end
    redirect_to action: 'index', status: 303
  end

  def disconnect
    session[:client_credential] = nil
    redirect_to action: 'index'
  end

  def index
    if session[:client_credential]
      @credential = session[:client_credential]
      #@token = credential.token
    end
  end
end
