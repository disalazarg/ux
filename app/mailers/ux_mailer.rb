class UxMailer < ApplicationMailer
  def greeter(contact)
    mail to: contact.email, subject: "invitation to participate"
  end

  def poll(contact, poll)
  end
end
