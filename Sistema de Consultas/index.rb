### CLASSE PARA CRIAÇÃO DO OBJETO PACIENTE
class Paciente
    attr_accessor :nome
    attr_accessor :telefone

    def initialize (nome, telefone)
        @nome = nome
        @telefone = telefone
    end

    def mostrar
        puts "Nome: " + @nome
        puts "Telefone: " + @telefone
    end

end


### CLASSE PARA CRIAÇÃO DO OBJETO AGENDAMENTO
class Agendamento
    attr_accessor :paciente
    attr_accessor :dia
    attr_accessor :hora
    attr_accessor :especialidade

    def initialize(paciente, dia, hora, especialidade)
        @paciente = paciente
        @dia = dia
        @hora = hora
        @especialidade = especialidade
    end


    def mostrar_agendamento
        puts "Nome do paciente: " + @paciente.nome
        puts "Data da consulta: " + @dia
        puts "Hora: " + @hora
        puts "Especialidade: " + @especialidade
    end

    def cancelar_agendamento
        puts "Data da consulta: " + @dia
        puts "Hora: " + @hora
        puts "Especialidade: " + @especialidade
    end


end


### FUNÇÃO PARA CADASTRAR PACIENTE
def cadastrar_paciente
    puts "\t\t\t Cadastro de Paciente"
    puts "Digite o nome do paciente: "
    nome = gets.chomp.to_s
    puts "Digite o telefone para contato: "
    telefone = gets.chomp.to_s
    return Paciente.new(nome, telefone)
end


### FUNÇÃO PARA MARCAR CONSULTA
def marcar_consulta (pacientes_cadastrados)
    numero_paciente = 0
    loop do
        indice = 1
        for pessoa in pacientes_cadastrados
            puts indice
            puts pessoa.mostrar
            indice += 1
        end
        puts "Selecione o número do paciente para a marcação de consulta:"
        numero_paciente = gets.chomp.to_i

        if (numero_paciente < 1 || numero_paciente > pacientes_cadastrados.length)
            puts "\n NÚMERO DE PACIENTE INVÁLIDO! \n"
            sleep 2
            system "clear"
        else
            break
        end
    end
    system "clear"
    puts "Digite o dia e o mês da consulta (dd/mm):"
    dia = gets.chomp
    puts "Digite a hora da consulta:"
    hora = gets.chomp
    puts "Digite a especialidade da consulta:"
    especialidade = gets.chomp

    return Agendamento.new(pacientes_cadastrados[numero_paciente - 1], dia, hora, especialidade)
end


### FUNÇÃO PARA CANCELAR CONSULTA
def cancelar_consulta (agendamentos)
    numero_agendamento = 0
    loop do
        indice = 1
        for consulta in agendamentos
            puts indice
            puts consulta.mostrar_agendamento
            indice += 1
        end
        puts "Selecione o agendamento que deseja cancelar:"
        numero_agendamento =  gets.chomp.to_i

        if (numero_agendamento < 1 || numero_agendamento > agendamentos.length)
            puts "\n NÚMERO DE AGENDAMENTO INVÁLIDO! \n"
            sleep 2
            system "clear"
        else
            break
        end
    end
    agendamentos[numero_agendamento - 1].cancelar_agendamento
    puts "\n\n Cancelar consulta? \n S - Sim ou N - Não"
    confirme = gets.chomp
    if (confirme.upcase == "S")
        return (numero_agendamento - 1)
    else
        return -1
    end

end





pacientes_cadastrados = []
agendamentos = []
cont_pacientes = 0
cont_agendamentos = 0


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
                pacientes_cadastrados[cont_pacientes] = cadastrar_paciente()
                puts "\n Paciente Cadastrado com Sucesso! \n"
                sleep 3
                system "clear"
                cont_pacientes += 1

            when 2
                system "clear"
                agendamentos[cont_agendamentos] = marcar_consulta(pacientes_cadastrados)
                puts "\n\n Agendamento realizado com sucesso!\n\n"
                sleep 3
                system "clear"
                cont_agendamentos += 1


            when 3
                system "clear"
                numero_agendamento = cancelar_consulta(agendamentos)
                if (numero_agendamento != -1)
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
        # system "clear"
    end
end


