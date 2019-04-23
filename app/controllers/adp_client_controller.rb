class AdpClientController < ApplicationController
  before_action :set_credential

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

  def subscription
    if session[:client_credential]
      connection = Adp.client_connection
      connection.connect()
      url = 'https://api.adp.com/core/v1/consumer-application-subscription-credentials'
      @subscription = connection.get_adp_data(url)
      render :index
    end
  end

  def workers
    if session[:client_credential]
      connection = Adp.client_connection
      connection.connect()
      url = 'https://test-api.adp.com/hr/v2/workers'
      @workers = connection.get_adp_data(url)
      render :index
    end
  end

  def demographics
    if session[:client_credential]
      connection = Adp.client_connection
      connection.connect()
      url = 'https://test-api.adp.com/hr/v2/worker-demographics'
      @demographics = connection.get_adp_data(url)
      render :index
    end
  end

  def index
  end

  private

  def set_credential
    if session[:client_credential]
      @credential = session[:client_credential]
    end
  end
end
