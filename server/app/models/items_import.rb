
class ItemsImport
  include ActiveModel::Model
  require 'roo-xls'
  require 'date'

  def import
    files = Dir["/mnt/c/rails/files/*.xls"]

    truncate_tables

    files.each do |file|
      puts "Processing #{file}..."
      customer_name = File.basename(file, ".*")
      process_file(customer_name, file)
    end
  end

  private

  def truncate_tables
    Transaction.delete_all
    Balance.delete_all
    # Customer.delete_all
  end

  def process_file(customer_name, file_path)
    spreadsheet = Roo::Excel.new(file_path)

    [0, 1].each do |sheet_number|
      process_sheet(customer_name, spreadsheet.sheet(sheet_number), sheet_number)
    end

  end

  def process_sheet(customer_name, sheet, transaction_type)
    #sheet has rows
    if sheet.last_row
      # we are duplicating this, no need. Find a way to do this only once
      customer_id = verify_customer_name(customer_name)

      if sheet.last_row > 3
        (4..sheet.last_row).map do |i|
          process_row(customer_id, transaction_type, sheet.row(i))
        end
      end

      # create balance entry
      Balance.create({
          :customer_id => customer_id
                               })

    end
  end

  def process_row(customer_id, transaction_type, row)
    if is_row_valid(row)
      Transaction.create({
                             :customer_id => customer_id,
                             :transaction_type => transaction_type,
                             :invoice_number => row[0],
                             :invoice_date => parse_date(row[1]),
                             :invoice_amount => row[3],
                             :balance => row[4],
                             :payment_receipt => row[5],
                             :payment_bank => row[6],
                             :payment_date => parse_date(row[7]),
                             :payment_amount => row[8]
                         })

    end
  end

  def parse_date(date)
    if date.nil?
      return nil
    end

    begin
      Date.parse(date.to_s)
    rescue StandardError => e
      nil
    end
  end

  def is_row_valid(row)
    !(!row[3] && !row[4])
  end

  def verify_customer_name(customer_name)
    customer = Customer.find_by(name: customer_name)

    if (!customer)
      customer = Customer.create( {
          :name => customer_name
                       })
    end

    customer.id
  end
end