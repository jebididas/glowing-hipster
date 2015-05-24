class CohortsImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/data/cohorts.csv")
    @filename = filename
  end

  def import
    field_names = ['name', 'public', 'admin', 'created_at', 'updated_at', 'password']

    print "Importing cohorts from #{@filename}: "
    failure_count = 0

    Cohort.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          cohort = Cohort.create!(attribute_hash)
          print "."; STDOUT.flush
        rescue ActiveRecord::UnknownAttributeError
          print "!"; STDOUT.flush
          failure_count += 1
        end
      end
    end
    failures = "(failed to create #{failure_count} cohort records)" if failure_count > 0
    puts "\nDONE #{failures}\n\n"
  end

end