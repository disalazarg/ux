class UxMailerPreview < ActionMailer::Preview
  
  def poll
    UxMailer.poll(User.first, Product.any)
  end

end
