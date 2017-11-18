class SapService

  def initialize
    # Resources
    @bancohoras = 'ZHR_CONSBANCOHORAS_INTRANET'
    @certificado = ''
    @contracheque = ''
    @descontos = 'Z_GET_DESC_INFO14'
    @avaliacaofuncional = 'ZHR_CONSAVALFUNC2_INTRANET'
    @emailmatricula = 'ZBOT_EMAIL_MATRICULA'
    @espelhocrediario = 'ZGET_ESPELHOCREDIARIO'
  end

  def sap(resource, data)
    RestClient.post 'http://apiqas.bemol.com.br:9000/sap/' + resource,
                    data,
                    {:Authorization => 'bemolPVM pvm2012'}
  end

  def get_descontos(matricula, data_inicio, data_fim)
    data = {
        :I_PERNR => matricula,
        :I_PERBG => data_inicio,
        :I_PERED => data_fim,
    }.to_json
    result = sap(@descontos, data)
    JSON.parse(result.body)
  end

  def get_emailmatricula(email)
    data = {
        :I_EMAIL => email
    }.to_json
    result = sap(@emailmatricula, data)
    JSON.parse(result.body)[@emailmatricula]
  end

  def get_espelhocrediario(matricula, periodo)
    data = {
        :i_FUNCIONARIO => matricula,
        :I_PERIODO     => periodo,
        :I_FUNCBEMOL   => "X",
    }.to_json
    result = sap(@espelhocrediario, data)
    JSON.parse(result.body)[@espelhocrediario]
  end

  def get_bancohoras(matricula, data_inicio, data_fim)
    data = {
        :I_PERNR => matricula,
        :I_PERBG => data_inicio,
        :I_PERED => data_fim,
    }.to_json
    result = sap(@bancohoras, data)
    JSON.parse(result.body)[@bancohoras]
  end

  def get_avaliacaofuncional(matricula, tipo, data_inicio, data_fim)
    case tipo
      when "selecionado"
        data = {
            :I_TP_VISUAL => "PAF",
            :I_PERNR     => matricula,
            :I_PERBG     => data_inicio,
            :I_PERED     => data_fim
        }.to_json
      else
        data = {
            :I_TP_VISUAL => "GRL",
            :I_PERNR     => matricula,
        }.to_json
    end
    result = sap(@avaliacaofuncional, data)
    JSON.parse(result.body)[@avaliacaofuncional]
  end

end