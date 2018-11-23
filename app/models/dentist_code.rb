class DentistCode < ApplicationRecord

  validates :code, uniqueness: true

  class << self
    def import_all_in_folder folder_path
      list_file = Dir["#{folder_path}/*"]
      import_result = []
      list_file.each do |file_path|
        import_result = import_result + import(file_path)
      end
      puts import_result
    end

    def import path
      success_count = 0
      failure_count = 0
      category = path.split("/").last
      File.open(path, "r") do |f|
        f.each_line do |line|

          dc = DentistCode.new code: line.chomp, category: category
          if dc.save
            success_count = success_count + 1
          else
            failure_count = failure_count + 1
          end
        end
      end
      ["success: #{success_count}, failure: #{failure_count}, category: #{category}"]
    end

    def export path
      File.open(path, "w") do |file| 
        DentistCode.all.each do |dc|
          file.write("#{dc.code}\n")
        end
      end
    end
  end
end
