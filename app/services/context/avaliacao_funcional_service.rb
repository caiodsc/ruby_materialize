module ContextModule
  class AvaliacaoFuncionalService
    def initialize(action, params)
      # TODO: identify origin
      @action = action
      @params = params
      #@id = params["id"]
    end

    def call
      begin
      #rescue
      end
      case @action
        when 'minha_avaliacao'
          years_list = (Date.today.year-3..Date.today.year).to_a
          response =
          {
              "messages": [
                  {
                      "platform": "facebook",
                      "type": 2,
                      "title": "Qual contracheque deseja visualizar? 💵",
                      "replies": years_list
                  }
              ]
          }.to_json
          return response
        when 'ano_escolhido'
          return "Ano escolhido"
        else
          return
      end
    end
  end
end
