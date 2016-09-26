module ApplicationHelper
  $rand = Random.new

  def prepare_data answers
    data = answers
      .map(&:to_datapoint)

    (1..3).map do |i|
      data
        .select {|x| x.last == i}
        .map {|x| x.take 2 }
        .map {|x| [to_angle(x.last), x.first] }
    end
  end

  def prepare_gauge base, answers
    [50, 70, 34]
  end

  def to_angle num
    120 * (num - 1) + ($rand.rand 20..100)
  end
end
