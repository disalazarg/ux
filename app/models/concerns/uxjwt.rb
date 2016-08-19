module UXJWT
  require 'jwt'

  @@secret = "please change this to a proper secret"
  def self.encode data
    JWT.encode({ data: data, iss: "Ux" }, @@secret, "none")
  end

  def self.decode token
    JWT.decode(token, @@secret, false, { algorithm: "none", iss: "Ux", verify_iss: true })
      .first
      .[] "data"
  end
end