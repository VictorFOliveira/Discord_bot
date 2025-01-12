from discord.ext import commands
from discord.ui import Button, View
import discord
import os

@commands.command()
async def infoSQL(ctx):
    await ctx.send(
        f'Comandos SQL disponíveis:\n\n'
        '- !sql_select: Mostra como realizar uma consulta de select no SQL.\n'
        '- !sql_insert: Mostra como realizar uma inserção de dados no SQL.\n'
        '- !sql_update: Mostra como realizar uma atualização de dados no SQL.\n'
        '- !sql_delete: Mostra como realizar uma exclusão de dados no SQL.\n'
        '- !sql_database: Mostra como criar uma database no SQL.\n'
        '- !sql_create_table: Mostra como criar uma tabela no SQL.\n'
        '- !sql_alter_table: Mostra como alterar a estrutura de uma tabela no SQL.\n'
        '- !sobre_injection: Explica sobre a vulnerabilidade SQL Injection e como se proteger.\n'
        '- !normalizacao: Explica os conceitos de normalização de banco de dados.\n'
    )

@commands.command()
async def conceito_bd(ctx):
    await ctx.send(
        '💾 **Conceitos de Banco de Dados** 💾\n\n'
        'Aqui estão alguns conceitos importantes para quem trabalha com bancos de dados:\n\n'
        '🔑 **Chave Primária:** A chave primária é um campo único de uma tabela que identifica de forma exclusiva cada registro. Ela nunca pode ser duplicada.\n'
        '📊 **Índices:** Índices ajudam a acelerar a busca por dados nas tabelas. Eles criam uma estrutura que facilita as consultas de leitura.\n'
        '📑 **Relacionamento:** Em bancos de dados relacionais, tabelas podem ser associadas entre si. Por exemplo, uma tabela de pedidos pode ter um relacionamento com a tabela de clientes.\n\n'
        'Esses são conceitos chave para a compreensão e otimização de bancos de dados.'
    )


@commands.command()
async def normalizacao(ctx):
    await ctx.send(
        f'🔍 **O que é Normalização de Banco de Dados?** 🔍\n\n'
        'A normalização organiza dados para reduzir redundâncias e dependências.\n\n'
        '**As 3 Primeiras Formas Normais (1NF, 2NF, 3NF):**\n\n'
        '🔶 **1ª Forma Normal (1NF):** Garante que cada coluna tenha valores atômicos, ou seja, apenas um valor por célula.\n'
        'Exemplo: Em vez de armazenar múltiplos números de telefone em uma célula, crie uma linha para cada número.\n\n'
        '🔶 **2ª Forma Normal (2NF):** Elimina dependências parciais. A tabela deve estar em 1NF e todas as colunas não-chave devem depender completamente da chave primária.\n'
        'Exemplo: Se uma tabela de alunos tem o nome do curso repetido, separe os dados em tabelas diferentes: uma para alunos e outra para cursos.\n\n'
        '🔶 **3ª Forma Normal (3NF):** Elimina dependências transitivas. Colunas não-chave devem depender apenas da chave primária.\n'
        'Exemplo: Se a tabela de clientes contém dados sobre cidade e estado, separe essas informações em tabelas distintas.\n\n'
        '**Resumo:**\n'
        'A normalização é essencial para evitar redundância e garantir a integridade dos dados. A 1NF, 2NF e 3NF ajudam a organizar o banco de dados de forma eficiente e segura.\n\n'
        '💡 **Dica:** Após a 3NF, pode ser necessário desnormalizar para otimizar a performance em consultas mais complexas.'
    )


@commands.command()
async def sobre_injection(ctx):
    await ctx.send(
        '🔒 **O que é SQL Injection?** 🔒\n\n'
        'SQL Injection é uma vulnerabilidade onde um atacante insere código SQL malicioso em campos de entrada para manipular o banco de dados.\n\n'
        '🚨 **Como funciona?** 🚨\n\n'
        'Exemplo: em um formulário de login, sem validação adequada, o atacante pode inserir código SQL como:\n'
        '```sql\n'
        'usuário = "admin" --\n'
        'senha = "qualquer_coisa"\n'
        '```\n'
        'Isso faz o sistema aceitar o atacante como administrador.\n\n'
        '⚠️ **Consequências** ⚠️\n'
        '1. Vazamento de dados sensíveis.\n'
        '2. Modificação ou exclusão de dados.\n'
        '3. Execução de comandos no servidor.\n\n'
        '💡 **Como evitar?** 💡\n'
        '1. Use **prepared statements** (exemplo em Python):\n'
        '```python\n'
        'cursor.execute("SELECT * FROM usuarios WHERE username = %s AND password = %s", (usuario, senha))\n'
        '```\n'
        '2. Valide as entradas do usuário.\n'
        '3. Evite concatenar strings diretamente nas consultas.\n\n'
        '🔗 **Recursos úteis**:\n'
        '- [OWASP SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)\n'
        '- [Django - Proteção contra SQL Injection](https://docs.djangoproject.com/en/stable/ref/models/querysets/#sql-injection)\n'
        '⚠️ **Segurança nunca é 100% garantida**, mas boas práticas reduzem riscos!'
    )


@commands.command()
async def sql_alter_table(ctx):
    await ctx.send(
        'O coelho da TI AJUDA SIM!\n\n'
        'O comando `ALTER TABLE` é utilizado para modificar uma tabela existente.\n\n'
        '**Alterar a estrutura da tabela**:\n'
        'Você pode adicionar, excluir ou modificar colunas em uma tabela já existente.\n\n'
        '**Exemplo de adicionar uma coluna**:\n'
        '```sql\n'
        'ALTER TABLE clientes ADD endereco VARCHAR(255);\n'
        '```'
        '**Exemplo de modificar uma coluna**:\n'
        '```sql\n'
        'ALTER TABLE clientes ALTER COLUMN endereco SET DATA TYPE TEXT;\n'
        '```'
        '**Exemplo de excluir uma coluna**:\n'
        '```sql\n'
        'ALTER TABLE clientes DROP COLUMN endereco;\n'
        '```')

@commands.command()
async def sql_create_table(ctx):
    await ctx.send(
        'O coelho da TI AJUDA SIM!\n\n'
        'O comando `CREATE TABLE IF NOT EXISTS` é utilizado para criar uma tabela em um banco de dados. '
        'A principal vantagem de usar o `IF NOT EXISTS` é evitar a criação de uma tabela que já exista no banco de dados, prevenindo erros de duplicação. '
        'Quando você usa `IF NOT EXISTS`, o banco de dados verifica se a tabela já existe antes de tentar criá-la, evitando o erro que ocorreria caso tentássemos criar uma tabela com o mesmo nome de uma tabela já existente.\n\n'
        '**Estrutura do comando**:\n\n'
        '```sql\n'
        'CREATE TABLE IF NOT EXISTS nome_da_tabela (\n'
        '    coluna1 tipo_dado,\n'
        '    coluna2 tipo_dado,\n'
        '    coluna3 tipo_dado\n'
        ');\n'
        '```'
        '**Exemplo**:\n\n'
        'Vamos imaginar que você quer criar uma tabela chamada `clientes` para armazenar dados como nome, idade e email.\n'
        'A consulta seria:\n\n'
        '```sql\n'
        'CREATE TABLE IF NOT EXISTS clientes (\n'
        '    id SERIAL PRIMARY KEY,\n'
        '    nome VARCHAR(100),\n'
        '    idade INT,\n'
        '    email VARCHAR(100)\n'
        ');\n'
        '```'
        '**Motivo para usar `IF NOT EXISTS`**:\n\n'
        'O `IF NOT EXISTS` é extremamente útil para garantir que, caso a tabela já tenha sido criada previamente, o comando não gere um erro. '
        'Isso é especialmente importante quando estamos trabalhando com scripts automatizados ou quando não temos controle total sobre o estado do banco de dados.\n\n'
        '**Recomendações**:\n\n'
        '1. Use `IF NOT EXISTS` quando precisar garantir que uma tabela será criada apenas uma vez, sem gerar erros em execuções subsequentes.\n'
        '2. Ideal para ambientes de desenvolvimento ou scripts de inicialização de banco de dados que precisam ser executados várias vezes.\n'
        '3. Utilize este comando em conjunto com a estrutura correta de tipos de dados e chaves primárias para garantir a integridade dos dados.\n\n'
        '**Desrecomendações**:\n\n'
        '1. Evite o uso excessivo do `IF NOT EXISTS` em sistemas onde você tem controle total sobre a estrutura do banco de dados. '
        'Em alguns casos, é mais apropriado verificar explicitamente a existência de tabelas antes de executar o comando, para evitar que a criação da tabela passe despercebida.\n'
        '2. Não use `IF NOT EXISTS` quando estiver realizando alterações estruturais, como adicionar ou excluir colunas. Em tais casos, o ideal é usar comandos separados de `ALTER TABLE` para garantir que as alterações sejam aplicadas corretamente.\n\n'
        '**Nota importante**:\n\n'
        'O `IF NOT EXISTS` não impede a alteração da tabela, apenas impede a criação de uma nova tabela com o mesmo nome. '
        'Se você tentar criar uma tabela com um nome já existente, o banco de dados simplesmente não fará nada e continuará normalmente, sem gerar erro.'
    )

@commands.command()
async def sql_database(ctx):
    await ctx.send(
        'O coelho da TI AJUDA SIM!\n\n'
        'Para criar o database é muito facil. Basta seguir os passos abaixo:\n\n'
        'Embora alguns SGBDS, façam a criação sem precisar digitar código algum, caso tu precise, agora vai saber\n'
        '``` create database nome_do_banco;````\n\n\n'
        'DE NADA')

@commands.command()
async def sql_delete(ctx):
    await ctx.send(
        'O coelho da TI AJUDA SIM!\n\n'
        'O comando `DELETE` é utilizado para excluir dados de uma tabela. Para realizar um `DELETE`, você precisa seguir a seguinte estrutura:\n\n'
        '- Primeiro, você usa o comando `DELETE FROM`, seguido pelo nome da tabela de onde deseja excluir os dados.\n'
        '- Em seguida, você utiliza a cláusula `WHERE` para especificar qual registro ou registros deseja excluir.\n'
        '- Caso não utilize a cláusula `WHERE`, **todos os dados da tabela serão excluídos**, então é importante utilizá-la com cuidado.\n\n'
        '**Exemplo**:\n\n'
        'Vamos imaginar que temos uma tabela chamada `CLIENTES` e queremos excluir o cliente com `id = 1`.\n\n'
        'A consulta seria:\n\n'
        '```sql\n'
        'DELETE FROM CLIENTES\n'
        'WHERE id = 1;\n'
        '```'
        '\nEssa consulta vai excluir o cliente da tabela `CLIENTES` que tem o `id` igual a 1.\n'
        'Lembre-se de que a cláusula `WHERE` é fundamental para garantir que apenas o(s) registro(s) desejado(s) sejam excluídos. Se você não usar `WHERE`, todos os registros da tabela serão apagados!\n'
        'Então, tenha sempre cuidado ao executar o comando `DELETE`!')

@commands.command()
async def sql_update(ctx):
    await ctx.send(
        'O coelho da TI AJUDA SIM!\n\n'
        'Os comandos de `UPDATE` são usados para atualizar dados em uma tabela existente. Para realizar um `UPDATE`, você precisa seguir a seguinte estrutura:\n\n'
        '- Primeiro, você usa o comando `UPDATE`, seguido pelo nome da tabela que deseja atualizar.\n'
        '- Em seguida, você utiliza o comando `SET`, onde você define os novos valores das colunas que deseja modificar.\n'
        '- Por último, você utiliza a cláusula `WHERE` para especificar a condição que os dados precisam atender para serem atualizados.\n\n'
        '**Exemplo**:\n\n'
        'Vamos imaginar que temos uma tabela chamada `CLIENTES`, e queremos atualizar o nome, idade e peso do cliente com `id = 1`.\n\n'
        'A consulta seria:\n\n'
        '```sql\n'
        'UPDATE CLIENTES\n'
        'SET nome = "Maria", idade = 30, peso = 65\n'
        'WHERE id = 1;\n'
        '```'
        '\nEssa consulta vai atualizar os dados de nome, idade e peso do cliente com o `id` igual a 1.\n'
        'Lembre-se de que a cláusula `WHERE` é importante para garantir que apenas o registro desejado seja alterado. Se você não utilizar `WHERE`, todos os registros da tabela serão atualizados!'
    )

@commands.command()
async def sql_insert(ctx):
    await ctx.send(
        'O coelho da TI AJUDA SIM!\n\n'
        'Os comandos `INSERT INTO`, você precisa primeiro informar o comando `INSERT INTO`, logo em seguida o nome da tabela que deseja inserir os dados, '
        'e entre parênteses, as colunas nas quais deseja inserir os dados.\n\n'
        'Depois, você usa o comando `VALUES`, que corresponde aos valores que serão inseridos em cada coluna.\n\n'
        'Exemplo:\n\n'
        '```sql\n'
        'INSERT INTO CLIENTES(nome, idade, peso) VALUES ("João", 25, 80);\n'
        '```')

@commands.command()
async def sql_select(ctx):
    await ctx.send(
        'O coelho da TI AJUDA SIM!\n\n'
        'As consultas SELECT, você precisa primeiro informar o comando `SELECT`, logo em seguida as colunas que você deseja que sejam exibidas, '
        'e por fim, o comando `FROM`, e por último, o nome da tabela.\n\n'
        'Exemplo: Se eu tenho uma tabela chamada `clientes` e quero que sejam exibidas as colunas `nome`, `idade`, e `peso`, '
        'a consulta será:\n\n'
        '```sql\n'
        'SELECT nome, idade, peso\n'
        'FROM clientes;\n'
        '```')

scripts_path = 'scripts/PostgreSQL'

@commands.command()
async def script(ctx):
    # Criação do botão principal
    button = Button(label="Mostrar Scripts", style=discord.ButtonStyle.green)

    # Criação da View que irá conter os botões
    view = View()
    view.add_item(button)

    # Envio da mensagem inicial
    await ctx.send("Temos esses scripts feitos para o banco PostgreSQL:", view=view)

    async def button_callback(interaction):
        if interaction.user == ctx.author:
            try:
                if not os.path.exists(scripts_path):
                    await interaction.response.send_message(
                        "A pasta de scripts não foi encontrada.", ephemeral=True)
                    return

                scripts = os.listdir(scripts_path)
                scripts = [
                    s for s in scripts
                    if os.path.isfile(os.path.join(scripts_path, s))
                ]

                if not scripts:
                    await interaction.response.send_message(
                        "Nenhum script disponível no momento.", ephemeral=True)
                else:
                    buttons = []
                    for script in scripts:
                        button = Button(
                            label=script,
                            style=discord.ButtonStyle.primary,
                            custom_id=script
                        )
                        buttons.append(button)

                    view = View()
                    for button in buttons:
                        view.add_item(button)

                    await interaction.response.send_message(
                        "Escolha um script para baixar:", view=view)

                    async def script_button_callback(interaction):
                        if interaction.user == ctx.author:
                            script_name = interaction.data["custom_id"]

                            script_file_path = os.path.join(scripts_path, script_name)

                            if os.path.exists(script_file_path):
                                await interaction.response.send_message(
                                    file=discord.File(script_file_path),
                                    content=f"Aqui está o script solicitado: {script_name}"
                                )
                            else:
                                await interaction.response.send_message(
                                    "Ocorreu um erro ao tentar acessar o script.", ephemeral=True)
                        else:
                            await interaction.response.send_message(
                                "Você não tem permissão para ver este script.", ephemeral=True)

                    for button in buttons:
                        button.callback = script_button_callback

            except Exception as e:
                await interaction.response.send_message(
                    f"Ocorreu um erro ao tentar carregar os scripts: {e}",
                    ephemeral=True)
        else:
            await interaction.response.send_message(
                "Você não tem permissão para ver os scripts.", ephemeral=True)

    button.callback = button_callback