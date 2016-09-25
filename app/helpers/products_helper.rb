module ProductsHelper
  def prepare_data product
    data = product
      .answers
      .internal
      .map(&:to_datapoint)

    [0,1,2].map {|i| data.select {|x| x.last == i}.map {|x| x.take 2}}
  end
end
