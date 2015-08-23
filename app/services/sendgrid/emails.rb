module Sendgrid
  # Handles creating, updating, and destroying emails that are held
  # on Sendgrid for marketing
  class Emails

    def self.create(details = {})
      toolkit_obj.add(
        list: ENV['SENDGRID_LIST'],
        data: details.except!('old_email')
      )
    end

    def self.destroy(details = {})
      toolkit_obj.delete(
        list: ENV['SENDGRID_LIST'],
        email: details['old_email'] || details['email']
      )
    end

    def self.update(details = {})
      destroy(details)
      create(details)
    end

    def self.toolkit_obj
      SendgridToolkit::ListEmails.new(
        ENV['EMAIL_USERNAME'], ENV['EMAIL_PASSWORD']
      )
    end

  end
end
