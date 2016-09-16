module Answerable
  def self.process params
    answer = Answer.new

    (1..5).each do |i|
      answer.picks.build params["q#{i}".to_sym]
    end

    answer
  end
end