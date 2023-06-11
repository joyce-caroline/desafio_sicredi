class Paciente
    attr_accessor :nome
    attr_accessor :telefone

    def initialize (nome, telefone)
        @nome = nome
        @telefone = telefone
    end

    def mostrar
        puts "\t\t\tPaciente"
        puts "Nome: " + @nome
        puts "Telefone: " + @telefone
    end

end

class Consulta
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


    def mostrar_consulta
        puts "Nome do paciente: " + @paciente
        puts "Data da consulta: " + @dia
        puts "Hora: " + @hora
        puts "Especialidade: " + @especialidade
    end

end





pacientes_cadastrados = []
cont_pacientes = 0

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
                puts "Paciente Cadastrado com Sucesso!"
                cont_pacientes += 1

            when 2
                puts '2'
            when 3
                puts '3'
            when 4
                puts '4'
        end
    end
    if opcao == 0
        break
    else
        result = "Valor Inválido"
        # system "clear"
    end
end


