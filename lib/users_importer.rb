class UsersImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/data/users.csv")
    @filename = filename
  end

  def import
    field_names = ['username', 'email', 'password', 'created_at', 'updated_at']

    print "Importing users from #{@filename}: "
    failure_count = 0

    User.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          plusone = User.create!(attribute_hash)
          print "."; STDOUT.flush
        rescue ActiveRecord::UnknownAttributeError
          print "!"; STDOUT.flush
          failure_count += 1
        end
      end
    end
    failures = "(failed to create #{failure_count} user records)" if failure_count > 0
    puts "\nDONE #{failures}\n\n"
  end

end
