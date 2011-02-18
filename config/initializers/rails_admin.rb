RailsAdmin.config do |config|
  config.excluded_models.push( Phenomenoning, Questioning, Commenting)

end

RailsAdmin.authenticate_with do
  require_admin
end
