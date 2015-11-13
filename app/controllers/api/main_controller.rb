class Api::MainController < ActionController::Metal

  WITHOUT = [
    AbstractController::Translation,
    AbstractController::AssetPaths,
    #ActionController::UrlFor,
    ActionController::Redirecting,
    #ActionController::Renderers::All,
    ActionController::ConditionalGet,
    ActionController::Caching,
    ActionController::MimeResponds,
    #ActionController::Cookies,
    ActionController::Flash,
    ActionController::RequestForgeryProtection,
    ActionController::ForceSSL,
    ActionController::Streaming,
    ActionController::DataStreaming,
    ActionController::HttpAuthentication::Basic::ControllerMethods,
    ActionController::HttpAuthentication::Digest::ControllerMethods,
    ActionController::HttpAuthentication::Token::ControllerMethods,
    ActionController::Instrumentation,
    ActionController::ParamsWrapper
  ]
      
  ActionController::Base.without_modules(*WITHOUT).each do |module_name|
    include module_name
  end
  
  private

  def query
    @query ||= params.except(:action, :controller).deep_symbolize_keys
  end
end