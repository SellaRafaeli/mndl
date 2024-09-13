# Simple flash messages. See http://www.seanbehan.com/roll-your-own-session-based-flash-messaging-w-sinatra
class FlashMessage
  def initialize(session)
    @session ||= session
  end

  def message=(message)
    @session[:flash] = message
  end

  def message
    message = @session[:flash] #get
    @session[:flash] = nil #unset
    message #return
  end
end

helpers do
  def flash
    @flash ||= FlashMessage.new(session)
  end
end