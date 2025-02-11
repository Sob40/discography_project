# frozen_string_literal: true

# Base model from which all models inherit
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
