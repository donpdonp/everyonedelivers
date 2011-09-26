# Run hourly
require 'maintenance'

# Clean out the clocked_in users older than an hour
Maintenance.clock_clean
