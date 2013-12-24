class Student < ActiveRecord::Base

  def name
    "#{salutation} #{first_name} #{last_name}"
  end

end
