require 'csv'
require 'date'

class Email
  attr_accessor :email, :date, :batch

  def initialize(email, date, batch)
    @email = email
    @date  = DateTime.parse date
    @batch = batch.to_i
  end

  def to_s
    "#{@email}, #{@date}"
  end

  def to_sql
    "(('#{@email}'), '#{@date}', 2, #{@batch})"
  end
end

list = Array.new
CSV.foreach 'mails.csv' do |row|
  list << Email.new(*row) if row.last =~ /\A\d+\z/
end

unless Batch.any?
  list.map(&:batch).uniq.map do |i|
    Batch.create(product_id: 2)
  end
end