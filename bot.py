import discord
from discord.ext import commands
from discord.ui import Button, View
import requests
import datetime
import io
from commands import command_helper, info_commands, sql_info_commands,command_helper, command_donation, command_ping, command_tempo


import os

bot = commands.Bot(command_prefix='!', intents=discord.Intents.all())

startup_time = None
 
@bot.event
async def on_ready():
        global startup_time
        if startup_time is None:
            startup_time = datetime.datetime.now()  # Definindo o tempo de inicialização ao estar pronto

        print(f'Bot conectado como {bot.user}!')
        for guild in bot.guilds:
            channel = guild.text_channels[0]  # Pegando o primeiro canal de texto da guilda
            if channel:
                try:
                    await channel.send(
                        '\n🐰🐰🐰🐰\n'
                        '\nGente, estou online já! Acesse o comando !infobot para ter acesso a minha lista de comandos.'
                    )
                except discord.Forbidden:
                    print(f"Sem permissão para enviar mensagens no canal {channel.name} de {guild.name}")
                except discord.HTTPException as e:
                    print(f"Erro ao enviar mensagem no canal {channel.name} de {guild.name}: {e}")
                    print(f'Bot conectado como {bot.user}!')



bot.add_command(info_commands.infobot)
bot.add_command(command_tempo.tempo)
bot.add_command(sql_info_commands.infoSQL)
bot.add_command(sql_info_commands.sobre_injection)
bot.add_command(sql_info_commands.normalizacao)
bot.add_command(sql_info_commands.conceito_bd)
bot.add_command(sql_info_commands.sql_create_table)
bot.add_command(sql_info_commands.sql_database)
bot.add_command(sql_info_commands.sql_alter_table)
bot.add_command(sql_info_commands.sql_select)
bot.add_command(sql_info_commands.sql_insert)
bot.add_command(sql_info_commands.sql_update)
bot.add_command(sql_info_commands.sql_delete)
bot.add_command(sql_info_commands.script)
bot.add_command(command_helper.helper)
bot.add_command(command_donation.donate_bitcoin)
bot.add_command(command_ping.ping)


@bot.command()
async def stats(ctx):
        # Verifica se o startup_time foi definido
        if startup_time is None:
            await ctx.send("O bot ainda não foi inicializado corretamente.")
            return

        # Calcular o tempo de atividade
        uptime = datetime.datetime.now() - startup_time
        uptime_minutes = round(uptime.total_seconds() / 60, 2)

        # Enviar a mensagem de estatísticas
        await ctx.send(
            f'Estou atualmente em {len(bot.guilds)} servidores e já estive online por {uptime_minutes} minutos! 🚀'
            'Obrigado por me usar! Caso precise de mais informações, me avise!'
        )



@bot.command()
async def chefe(ctx):
    await ctx.send(
        'O chefe ta formado em análise de sistemas pela Estácio, e está fazendo uma pós graduação em Administração de banco de dados, por isso você deve ta vendo um monte de comandos de SQL 🐰 '
    )


bot.run('YOUR_TOKEN_HERE')
