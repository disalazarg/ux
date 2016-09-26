module Answerable
  def self.process params
    answer = Answer.new params.permit(:contact_id, :product_id)

    (1..5).each do |i|
      pars = params["q#{i}".to_sym]
      answer.picks.build pars if pars
    end

    answer
  end
end