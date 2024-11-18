$emails_sent     = $mongo.collection('emails_sent')
$postmark_client = Postmark::ApiClient.new(ENV['POSTMARK_API_TOKEN'])

EMAILS_ON     = ENV['EMAILS_ON'].to_s == 'yes'
EMAILS_FROM   = 'eran@mndl.bio' # more "from" emails can be added on Postmark

# send_email('sella.rafaeli@gmail.com','mndl test '+Time.now.to_s,'mndl test '+Time.now.to_s)
def send_email(to, subj, html_body, opts = {})
  attachments = opts[:attachments].to_a  
  res         = 'unset'

  if EMAILS_ON
    Thread.new {
      res = $postmark_client.deliver(from: opts[:from] || EMAILS_FROM,
      to: to,
      subject: subj,
      html_body: html_body,
      Attachments: attachments,     
      track_opens: true)

      $emails_sent.add(res)
      puts "logged email sent: #{res}"
    }


    puts "sent email: #{res}"
  else 
    puts "Skipping email subject: #{subj} because !EMAILS_ON".red    
  end

  # $emails_sent.add(to: to, subj: subj, html_body: html_body, opts: opts, res: res)
rescue => e
  puts e.to_s.red
  log_e(e)
  false
end