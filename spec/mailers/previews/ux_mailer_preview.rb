# Preview all emails at http://localhost:3000/rails/mailers/ux_mailer
class UxMailerPreview < ActionMailer::Preview
  def poll
    UxMailer.poll(Contact.first, Product.first)
  end
end
