class InterpretService
  def self.call(context, action, params, facebookId)
    case context
      when "avaliacaofuncional"
        #return "Funcionou"
        ContextModule::AvaliacaoFuncionalService.new(action, params).call
      when "create"
        FaqModule::CreateService.new(params).call
      when "remove"
        FaqModule::RemoveService.new(params).call
      when "help"
        #ACCESS_TOKEN
        #HelpService.call()
        #Bot.deliver({
        #                recipient: {
        #                    id: facebookId.to_s
        #                },
        #                message: {
        #                    text: 'Human?'
        #                }
        #            }, access_token: ACCESS_TOKEN)
        #nome = 'caio'.encrypt
        #nome += nome.decrypt
        #nome
    else
      return "Não funcionou"
    end
  end
end
