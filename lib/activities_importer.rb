class ActivitiesImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/data/activities.csv")
    @filename = filename
  end

  def import
    field_names = ['description', 'start_time', 'end_time', 'plusone_id']

    print "Importing activities from #{@filename}: "
    failure_count = 0

    Activity.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          activity = Activity.create!(attribute_hash)
          print "."; STDOUT.flush
        rescue ActiveRecord::UnknownAttributeError
          print "!"; STDOUT.flush
          failure_count += 1
        end
      end
    end
    failures = "(failed to create #{failure_count} activity records)" if failure_count > 0
    puts "\nDONE #{failures}\n\n"
  end

end
