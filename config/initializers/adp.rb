require 'adp/connection'

module Adp
  def client_connection
    config = YAML.load_file("#{Rails.root.to_s}/config/adp/clientcredential_config.yml")
    clientcredential_config = Adp::Connection::ClientCredentialConfiguration.new(config);
    Adp::Connection::ApiConnectionFactory::createConnection(clientcredential_config)
  end
  module_function :client_connection

  module Connection
    class ClientCredentialConnection < ApiConnection
      # return [Object]
      def get_adp_data(product_url)
        raise ConnectionException, "Connection error: can't get data, not connected" unless self.access_token && is_connected_indicator?

        authorization = "#{self.access_token.token_type} #{self.access_token.token}"
        data = {
          "client_id"     => self.connection_configuration.clientID,
          "client_secret" => self.connection_configuration.clientSecret,
          "grant_type"    => self.connection_configuration.grantType
        }
        data = send_web_request(product_url, data, authorization, 'application/json', 'GET')

        raise ConnectionException, "Connection error: #{data['error']}, #{data['error_description']}" if data["error"]

        data
      end
    end
  end

end
