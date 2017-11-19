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
          #return Date.today.year
          years_list = (Date.today.year-3..Date.today.year).to_a
          content_type :json
          {
              "platform": "facebook",
              #"speech": "Qual contracheque deseja visualizar? 💵",
              "messages": [
                  {
                      "type": 2,
                      "title": "Qual contracheque deseja visualizar? 💵",
                      "replies": years_list
                  }
              ]
          }.to_json
        else
          return "Não funcionou!"
      end
    end
  end
end
