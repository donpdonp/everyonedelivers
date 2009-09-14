class Maintenance
  def self.clock_clean
    User.clocked_ins.each do |user|
      if user.clocked_in < Time.now - 1.hour
        user.clock_out!
        logger.info("Maintenance: clocked out #{user.username} #{user.clocked_in}")
      end
    end
  end
end
