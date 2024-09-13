require './app'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

EVERY_DAY_AT_11_AM                = '0 11 * * *' #time is GMT

scheduler.every '30m' do
  # daily report
end

scheduler.cron EVERY_DAY_AT_11_AM do
	# send_reminder_emails_about_tomorrows_casts
end

def pr; {}; end 
def session; {}; end 
def cu; nil; end

scheduler.join
