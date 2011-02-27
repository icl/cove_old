RailsAdmin.config do |config|
  config.excluded_models.push( Coding, Tagging )

end

RailsAdmin.authenticate_with do
  require_admin
end
