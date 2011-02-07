ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com"
}
=begin
class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "ethan.soutar.rau@gmail.com"
  end
end

ActionMailer::Base.default_url_options[:host] = "cove.ucsd.edu"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
=end