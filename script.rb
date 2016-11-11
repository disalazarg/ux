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
    "#{@email}, #{@date} (#{@batch})"
  end

  def to_sql(batch=@batch)
    "((SELECT contacts.id FROM contacts WHERE email = '#{@email}' ORDER BY id ASC LIMIT 1), #{batch})"
  end
end

list = Array.new
CSV.foreach 'mails.csv' do |row|
  list << Email.new(*row) if row.last =~ /\A\d+\z/
end

batches = Array.new

list.uniq(&:batch).sort_by(&:batch).map do |el|
  batches << Batch.create(product_id: 2, created_at: el.date, updated_at: el.date)
end

values = list.map do |elem|
  elem.to_sql(batches[elem.batch - 1].id)
end.join(", ")

ActiveRecord::Base.connection.execute "INSERT INTO batches_contacts(contact_id, batch_id) VALUES " + values