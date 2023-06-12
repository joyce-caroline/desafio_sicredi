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


    def mostrar_agendamento ()
        puts "Nome do paciente: " + @paciente.nome
        puts "Data da consulta: " + @dia
        puts "Hora: " + @hora
        puts "Especialidade: " + @especialidade
    end

end





pacientes_cadastrados = []
agendamentos = []
cont_pacientes = 0
cont_agendamentos = 0
indice = 1
numero_paciente = 0

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
                puts "\t\t\t Cadastro de Paciente"
                puts "Digite o nome do paciente: "
                nome = gets.chomp.to_s
                puts "Digite o telefone para contato: "
                telefone = gets.chomp.to_s
                pacientes_cadastrados[cont_pacientes] = Paciente.new(nome, telefone)
                pacientes_cadastrados[cont_pacientes].mostrar
                puts "Paciente Cadastrado com Sucesso!"
                cont_pacientes += 1

            when 2
                puts "Selecione o número paciente para a marcação de consulta:"
                loop do
                    for pessoa in pacientes_cadastrados
                        puts indice
                        puts pessoa.mostrar
                        indice += 1
                    end
                    numero_paciente = gets.chomp.to_i

                    if (numero_paciente < 1 || numero_paciente > pacientes_cadastrados.length)
                        puts "Número de paciente inválido!"
                    elsif (numero_paciente == 0)
                        break
                    end
                end
                if(numero_paciente > 0 && numero_paciente < pacientes_cadastrados.length)
                    puts "Digite o dia e o mês da consulta (dd/mm):"
                    dia = gets.chomp.to_s
                    puts "Digite a hora da consulta:"
                    hora = gets.chomp.to_s
                    puts "Digite a especialidade da consulta:"
                    especialidade = gets.chomp.to_s
                    agendamentos[cont_agendamentos] = Agendamento.new(pacientes_cadastrados[numero_paciente], dia, hora, especialidade)
                    puts "\n\n Agendamento realizado com sucesso!\n\n"
                    agendamentos[cont_agendamentos].mostrar_agendamento
                    cont_agendamentos += 1
                    indice = 1
                end
            when 3
                puts "Selecione o agendmento que deseja remarcar:"
                loop do
                    for consulta in agendamentos
                        puts indice
                        puts consulta.mostrar_agendamento
                        indice += 1
                    end

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


