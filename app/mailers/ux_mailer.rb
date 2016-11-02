class UxMailer < ApplicationMailer
  default from: 'encuesta@agenciadecalidad.cl'

  def greeter(contact)
    mail to: contact.email, subject: "invitation to participate"
  end

  def poll(contact, product)
    @contact = contact
    @product = product
    @token   = UXJWT.encode({ contact_id: contact.id, product_id: product.id })
    @url     = "http://uxagencia.ing.puc.cl/polls/1/answer?token=#{@token}"

    mail to: contact.email, subject: "Cinco preguntas para construir calidad"
  end
end
