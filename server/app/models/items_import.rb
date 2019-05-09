
class ItemsImport
  include ActiveModel::Model
  require 'roo-xls'
  require 'date'

  def import
    files = Dir["/mnt/c/rails/files/*.xls"]

    truncate_tables

    files.each do |file|
      puts "Processing #{file}..."
      process_file(file)

    end
  end

  private

  def truncate_tables
    Transaction.delete_all
    Balance.delete_all
  end

  def process_file(filePath)
    spreadsheet = Roo::Excel.new(filePath)
    if spreadsheet.sheet(0) != nil
      process_sheet(spreadsheet, 0)
    end

    if spreadsheet.sheet(1) != nil
      process_sheet(spreadsheet, 1)
    end
  end

  def process_sheet(spreadsheet, sheetNumber)
    puts "Processing sheet #{sheetNumber}"

    #sheet has rows
    if (spreadsheet.last_row)
      customerName = extract_customer_name(spreadsheet.sheet(sheetNumber))

      # we are duplicating this, no need. Find a way to do this only once
      customer_id = verify_customer_name(customerName)

      if (spreadsheet.last_row > 3)
        (4..spreadsheet.last_row).map do |i|
          process_row(customer_id, spreadsheet.row(i))
        end
      end

      # create balance entry
      Balance.create({
          :customer_id => customer_id
                               })

    end
  end

  def process_row(customer_id, row)
    if is_row_valid(row)
      Transaction.create({
                             :customer_id => customer_id,
                             :invoice_number => row[0],
                             :transaction_date => parse_date(row[1]),
                             :customer_name => row[2],
                             :amount => row[3],
                             :balance => row[4],
                             :receipt => row[5],
                             :bank => row[6],
                             :receipt_date => parse_date(row[7]),
                             :payment_amount2 => row[8]
                         })

    end
  end

  def parse_date(date)
    if (!date)
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

  def extract_customer_name(sheet)
    sheet.cell(1,1)
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