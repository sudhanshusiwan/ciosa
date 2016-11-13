ActionMailer::Base.smtp_settings = {
    :user_name            => "kanmaniselvan",
    :password             => "AAaa11!!",
    :domain               => "reportbee.com",
    :address              => "smtp.sendgrid.net",
    :port                 => 587,
    :authentication       => :plain,
    :enable_starttls_auto => true
}
