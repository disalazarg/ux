module Answerable
  def self.process params
    answer = Answer.new params.permit(:contact_id, :product_id)

    (1..5).each do |i|
      answer.picks.build params["q#{i}".to_sym]
    end

    answer
  end
end