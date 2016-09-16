module Answerable
  def self.process params
    answer = Answer.new

    (1..5).each do |i|
      p = "q#{i}"
      answer.picks.build params[p] unless params[p].nil?
    end

    answer
  end
end