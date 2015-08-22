module Sendgrid
  class Emails

    def self.create(details = {})
      self.toolkit_obj.add(
        list: ENV['SENDGRID_LIST'],
        data: details.except!('old_email')
      )
    end

    def self.destroy(details = {})
      self.toolkit_obj.delete(
        list: ENV['SENDGRID_LIST'],
        email: details['old_email'] || details['email']
      )
    end

    def self.update(details = {})
      self.destroy(details)
      self.create(details)
    end

    private

      def self.toolkit_obj
        SendgridToolkit::ListEmails.new(ENV['EMAIL_USERNAME'], ENV['EMAIL_PASSWORD'])
      end

  end
end