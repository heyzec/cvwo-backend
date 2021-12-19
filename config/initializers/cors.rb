# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'https://loving-hoover-c44549.netlify.app:443'
#     resource '*',
#       headers: :any,
#       methods: [:get, :post, :patch, :put]
#   end
# end