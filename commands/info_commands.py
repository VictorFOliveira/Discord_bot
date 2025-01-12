import datetime
import discord
from discord.ext import commands

startup_time = None

@commands.command()
async def infobot(ctx):
    await ctx.send(
        f'E ai, {ctx.author.mention}, esses são os meus comandos gerais:\n\n'
        '- !infobot: Mostra os comandos gerais do bot.\n'
        '- !helper: Envia o link do meu telegram para você entrar em contato comigo.\n'
        '- !donate_bitcoin: Um link do meu PayPal para você ajudar esse projetinho.\n'
        '- !Ping: Responde com a latência do bot, informando o tempo de resposta do servidor.\n'
        '- !tempo: Mostra o tempo atual do Brasil.\n'
        '- !stats: Exibe estatísticas do bot, como servidores conectados e tempo de atividade.\n'
        '- chefe: Informações do chefe e desenvolvedor.'
    )
