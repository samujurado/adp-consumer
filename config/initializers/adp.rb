require 'adp/connection'

module Adp
  def client_connection
    config = YAML.load_file("#{Rails.root.to_s}/config/adp/clientcredential_config.yml")
    clientcredential_config = Adp::Connection::ClientCredentialConfiguration.new(config);
    Adp::Connection::ApiConnectionFactory::createConnection(clientcredential_config)
  end
  module_function :client_connection
end
