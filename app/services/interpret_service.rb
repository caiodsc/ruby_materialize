class InterpretService
  def self.call(action, params, facebookId)
    case action
    when "list", "search", "search_by_hashtag"
      FaqModule::ListService.new(params, action).call()
    when "create"
      FaqModule::CreateService.new(params).call()
    when "remove"
      FaqModule::RemoveService.new(params).call()
    when "help"
      #ACCESS_TOKEN
      #HelpService.call()
      Bot.deliver({
                      recipient: {
                          id: facebookId.to_s
                      },
                      message: {
                          text: 'Human?'
                      }
                  }, access_token: ACCESS_TOKEN) && nil
    else
      "Não compreendi o seu desejo"
    end
  end
end
