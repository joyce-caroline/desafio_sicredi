require "time"
require "json"

### CLASSE PARA CRIAÇÃO DO OBJETO PACIENTE
class Paciente
    attr_accessor :nome
    attr_accessor :telefone

    #Função construtora
    def initialize (nome, telefone)
        @nome = nome
        @telefone = telefone
    end

    #Função que mostra os dados do paciente
    def mostrar
        puts "Nome: " + @nome
        puts "Telefone: " + @telefone
    end

    #Função que gera uma hash com os dados do paciente
    def to_hash
        return {"nome" => @nome, "telefone" => @telefone}
    end

end


### CLASSE PARA CRIAÇÃO DO OBJETO AGENDAMENTO
class Agendamento
    attr_accessor :paciente
    attr_accessor :dia
    attr_accessor :hora
    attr_accessor :especialidade

    #Função construtora
    def initialize(paciente, dia, hora, especialidade)
        @paciente = paciente
        @dia = dia
        @hora = hora
        @especialidade = especialidade
    end

    #Função para mostrar os dados da consulta
    def mostrar_agendamento
        puts "Nome do paciente: " + @paciente.nome
        puts "Data da consulta: " + @dia
        puts "Hora: " + @hora
        puts "Especialidade: " + @especialidade
    end

    #Função para mostrar os dados da consulta antes dela ser cancelada
    def cancelar_agendamento
        puts "Data da consulta: " + @dia
        puts "Hora: " + @hora
        puts "Especialidade: " + @especialidade
    end




end


### FUNÇÃO PARA CADASTRAR PACIENTE
def cadastrar_paciente (pacientes_cadastrados)

    puts "\t\t\t Cadastro de Paciente"
    puts "Digite o nome do paciente: "
    nome = gets.chomp.to_s
    puts "Digite o telefone para contato: "
    telefone = gets.chomp.to_s

    #Verificando se o paciente não está cadastrado
    for pessoa in pacientes_cadastrados
        if(pessoa.telefone == telefone)
            puts "\n Paciente já cadastrado! \n"
            return false
        end
    end

    #retorno do objeto Paciente
    return Paciente.new(nome, telefone)
end


### FUNÇÃO PARA MARCAR CONSULTA
def marcar_consulta (pacientes_cadastrados, agendamentos)

    hoje = Time.now  #Obtendo a data atual
    numero_paciente = 0

    loop do
        indice = 1

        #Mostra todos os pacientes cadastrados no sistema
        for pessoa in pacientes_cadastrados
            puts indice
            puts pessoa.mostrar
            indice += 1
        end
        puts "Selecione o número do paciente para a marcação de consulta:"
        numero_paciente = gets.chomp.to_i

        #Verifica se o número do paciente está dentro dos parametros de validade
        if (numero_paciente < 1 || numero_paciente > pacientes_cadastrados.length)
            puts "\n NÚMERO DE PACIENTE INVÁLIDO! \n"
            sleep 2
            system "clear"
        else
            break
        end
    end

    #Depois da seleção do paciente, recebe os dados do agendamento da consulta
    system "clear"
    puts "Digite o dia e o mês da consulta (dd/mm):"
    dia = gets.chomp
    puts "Digite a hora da consulta:"
    hora = gets.chomp
    puts "Digite a especialidade da consulta:"
    especialidade = gets.chomp

    #Verifica se o usuário está agendando uma data não-retroativa
    unless (hoje.month < dia.split("/", 2)[1].to_i) || (hoje.day < dia.to_i)
        puts "Data inválida!\n"
        return false
    end

    #Verifica se o horário e dia recebidos, não estão com agendamento.
    for consulta in agendamentos
        if(dia == consulta.dia) && (hora == consulta.hora)
            puts "\n Horário e dia já agendados! \n"
            puts "Tente outro horário! \n"
            return false
        end
    end

    #Retorno do objeto Agendamento.
    return Agendamento.new(pacientes_cadastrados[numero_paciente - 1], dia, hora, especialidade)
end


### FUNÇÃO PARA CANCELAR CONSULTA
def cancelar_consulta (agendamentos)

    numero_agendamento = 0

    #Verifica se já existe alguma consulta agendada.
    if (agendamentos.length === 0)
        return 0
    end

    loop do
        indice = 1
        #Mostra todas as conultas agendadas no sistema.
        for consulta in agendamentos
            puts indice
            puts consulta.mostrar_agendamento
            indice += 1
        end
        puts "Selecione o agendamento que deseja cancelar:"
        numero_agendamento =  gets.chomp.to_i

        #Verifica se o número da consulta está dentro dos parametros válidos.
        if (numero_agendamento < 1 || numero_agendamento > agendamentos.length)
            puts "\n NÚMERO DE AGENDAMENTO INVÁLIDO! \n"
            sleep 2
            system "clear"
        else
            break
        end
    end
    #Mostra os dados da consulta a ser cancelada.
    agendamentos[numero_agendamento - 1].cancelar_agendamento
    puts "\n\n Cancelar consulta? \n S - Sim ou N - Não"
    confirme = gets.chomp
    if (confirme.upcase == "S")
        #Retorna a posição que a consulta a ser cancelada está para ser retirada do vetor.
        return (numero_agendamento - 1)
    else
        return -1
    end
end

#Inicialização de variáveis globais
pacientes_cadastrados = [] #Lista com todos os pacientes cadastrados
agendamentos = [] #Lista com todas as consultas agendadas
cont_pacientes = 0 #Variável auxiliar para definir o local de cada objeto paciente
cont_agendamentos = 0 #Variável auxiliar para definir o local de cada objeto agendamento

#Código Principal
loop do
    puts "\t\t\t\t Sistema de Marcação de consultas"
    puts "Escolha a opção desejada: "
    puts "1 - Cadastrar paciente"
    puts "2 - Marcar Consulta"
    puts "3 - Cancelar consultas"
    puts "0 - Sair"
    opcao = gets.chomp.to_i

    if (opcao > 0 && opcao <=3)
        case opcao

            when 1
                system "clear"
                paciente = cadastrar_paciente(pacientes_cadastrados)

                if (paciente != false)
                    pacientes_cadastrados[cont_pacientes] = paciente
                    puts "\n Paciente Cadastrado com Sucesso! \n"
                    cont_pacientes += 1
                end

                #Geração de json com os dados do paciente para persistir dados no DB
                resultado = JSON.generate(paciente.to_hash)
                bd =File.open("db-table-pacientes.txt", "a+")
                bd.puts(resultado)
                bd.close

                sleep 2
                system "clear"

            when 2
                system "clear"
                consulta = marcar_consulta(pacientes_cadastrados, agendamentos)

                if(consulta != false)
                    agendamentos[cont_agendamentos] = consulta
                    puts "\n\n Agendamento realizado com sucesso!\n\n"
                    cont_agendamentos += 1
                end
                sleep 2
                system "clear"


            when 3
                system "clear"
                numero_agendamento = cancelar_consulta(agendamentos)
                if (numero_agendamento == 0)
                    puts "Sem agendamentos!"
                    sleep 2
                elsif (numero_agendamento != -1)
                    agendamentos.delete_at(numero_agendamento)
                    puts "\n Agendamento cancelado! \n"
                    sleep 2
                    system "clear"
                else
                    system "clear"
                end



            else
                puts "Opção inválida"
        end
    end
    if opcao == 0
        break
    else
        result = "Valor Inválido"
        system "clear"
    end
end


