# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Create teachers
["John Smith", "Foo Bar", "Mathew Richard", "Mohan Mathur", "Amit Trivedi"].each do |name|  
  fname, lname = name.split(" ")
  t = Teacher.new(salutation: "Mr", first_name: fname, last_name: lname, email: "#{fname}@#{lname.downcase}.com")
  if t.save
    print "Successfully created Teacher #{t.name} \n"
  else
    print "Could not create Teacher #{t.name} #{t.email}\n"
    print "ERRORS: #{t.errors.full_messages} \n"
  end 
end


# add tasks to teachers
Teacher.all.each do |teacher|
  Task::PRIORITIES.each do |priority|
    (1..4).each do |num|
      teacher.tasks << Task.new(title: "A New #{priority} Task - #{num}", description: "some description", priority: priority)
    end
  end
  
  print "Created tasks for teacher - #{teacher.email}. Task Count: #{teacher.tasks.count} \n"
end 



#create students
["ravi thakur", "amit kumar", "sanjeev kumar", "mukul shukla"].each do|name|
  fname,lname = name.split(" ")
  s =Student.new(first_name: fname, last_name: lname, email: "#{fname}@#{lname.downcase}.com")
  if s.save
    print "successfully created student #{s.name} \n"
  else
    print "could not create student #{s.email} \n"
    print "Errors: #{s.errors.full_messages} \n"
  end
end





# add labs to students

Student.all.each do |student|
  a = 1
  Labdesk::TYPES.each do |lab_type|     
    num = a  
    student.labdesks << Labdesk.new(lab_number: " lab number #{num} is ", lab_type: "#{lab_type}")
    a +=1 
  end
  print "created lab number for student - #{student.email}. Labdesk Count: #{student.labdesks.count} \n"
end

    
# add subjects    
%w(Physics Chemistry Mathematics English Biology Computers).each do |name|
  if Subject.create(name: name, description: "#{name} details")
    print "Created subject: #{name} \n"
  else
    print "ERROR: could not create subject: #{name} \n"
  end
end











