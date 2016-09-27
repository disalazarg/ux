module ApplicationHelper
  $rand = Random.new

  def prepare_data answers
    return [] if answers.nil? or answers.compact.empty?

    data = answers
      .map(&:to_graphpoint)

    (1..3).map do |i|
      data
        .select {|x| x.last == i}
        .map {|x| x.take 2 }
        .map {|x| [to_angle(x.last), x.first] }
    end
  end

  def prepare_gauge base, answers
    return [[0,0,0]] if base.nil? or answers.compact.empty?

    bdata = base.try :to_graphpoint
    adata = answers.map(&:to_graphpoint)

    count = {
      total:  adata.count,
      first:  adata.count { |x| x[0] == bdata[0] },
      second: adata.count { |x| x[1] == bdata[1] },
      third:  adata.count { |x| x[2] == bdata[2] }
    }

    synth  = 0
    synth += (count[:first]  / count[:total]) * 50
    synth += (count[:second] / count[:total]) * 25
    synth += (count[:third]  / count[:total]) * 25

    adata  = answers.map(&:to_datapoint)

    ease   = (3 * adata.count {|x| x[4] == 1}) + (adata.count {|x| x[4] == 2 })
    ease  *= 100.0 / (adata.count * 3)

    util   = (3 * adata.count {|x| x[1] == 1}) + (adata.count {|x| x[1] == 2 })
    util  *= 100.0 / (adata.count * 3)

    [synth, ease, util]
  end

  def to_angle num
    120 * (num - 1) + ($rand.rand 20..100)
  end
end
