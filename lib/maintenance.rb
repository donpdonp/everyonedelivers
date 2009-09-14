class Maintenance
  def self.clock_clean
    User.clocked_ins.each do |user|
      if user.clocked_in < Time.now - 1.hour
        user.clock_out!
        Journal.create({:delivery => nil, :user => nil, :note => "Clocked out #{user.username} after an hour"})
      end
    end
  end
end
