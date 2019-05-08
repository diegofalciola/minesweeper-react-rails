
class ItemsImport
  include ActiveModel::Model
  require 'roo-xls'

  def import
    files = Dir["/mnt/c/rails/files/*.xls"]

    files.each do |file|
      puts "Processing #{file}..."
      process_file(file)

    end
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
      verify_customer_name(customerName)

      if (spreadsheet.last_row > 3)
        (3..spreadsheet.last_row).map do |i|
          puts i.to_s
        end
      end


    end
  end

  private

  def extract_customer_name(sheet)
    sheet.cell(1,1)
  end

  def verify_customer_name(customerName)
    customer = Customer.find_by(name: customerName)

    if (customer)
      puts "existe"
    else
      puts "doesn't exist"
    end
  end

  # def open_spreadsheet
  #   case File.extname(file.original_filename)
  #   when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  #   when ".xlsx" then Roo::Excelx.new(file.path)
  #   else raise "Unknown file type: #{file.original_filename}"
  #   end
  # end
  #
  # def load_imported_items
  #   spreadsheet = open_spreadsheet
  #   header = spreadsheet.row(5)
  #   (6..spreadsheet.last_row).map do |i|
  #     row = Hash[[header, spreadsheet.row(i)].transpose]
  #     item = Item.find_by_id(row["id"]) || Item.new
  #     item.attributes = row.to_hash
  #     item
  #   end
  # end
  #
  # def imported_items
  #   @imported_items ||= load_imported_items
  # end
  #
  # def save
  #   if imported_items.map(&:valid?).all?
  #     imported_items.each(&:save!)
  #     true
  #   else
  #     imported_items.each_with_index do |item, index|
  #       item.errors.full_messages.each do |msg|
  #         errors.add :base, "Row #{index + 6}: #{msg}"
  #       end
  #     end
  #     false
  #   end
  # end

end