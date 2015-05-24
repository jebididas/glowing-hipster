class EnrollmentsImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/data/enrollments.csv")
    @filename = filename
  end

  def import
    field_names = ['user_id', 'cohort_id', 'enrollment_date']

    print "Importing enrollments from #{@filename}: "
    failure_count = 0

    Enrollment.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          enrollment = Enrollment.create!(attribute_hash)
          print "."; STDOUT.flush
        rescue ActiveRecord::UnknownAttributeError
          print "!"; STDOUT.flush
          failure_count += 1
        end
      end
    end
    failures = "(failed to create #{failure_count} enrollment records)" if failure_count > 0
    puts "\nDONE #{failures}\n\n"
  end

end
