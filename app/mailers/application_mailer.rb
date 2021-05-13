# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['FROMMAIL']
  layout 'mailer'
end
