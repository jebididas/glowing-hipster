class PlusonesImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/data/plusones.csv")
    @filename = filename
  end

  def import
    field_names = ['score', 'created_at', 'updated_at', 'user_id']

    print "Importing plusones from #{@filename}: "
    failure_count = 0

    Plusone.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          plusone = Plusone.create!(attribute_hash)
          print "."; STDOUT.flush
        rescue ActiveRecord::UnknownAttributeError
          print "!"; STDOUT.flush
          failure_count += 1
        end
      end
    end
    failures = "(failed to create #{failure_count} plusone records)" if failure_count > 0
    puts "\nDONE #{failures}\n\n"
  end

end
