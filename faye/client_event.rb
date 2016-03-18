class ClientEvent
  MONITORED_CHANNELS = [ '/meta/subscribe', '/meta/disconnect', '/meta/message' ]

  def incoming(message, callback)
    puts message.inspect
    return callback.call(message) unless MONITORED_CHANNELS.include? message['channel']

    faye_client.publish('/messages/new', { 'message' => { 'content' => "An event happened!"} })
    callback.call(message)
  end

  def faye_client
    @faye_client ||= Faye::Client.new('http://omnistrimfaye.herokuapp.com/faye')
  end
end
