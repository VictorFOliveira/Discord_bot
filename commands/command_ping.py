import discord
from discord.ext import commands


@commands.command()
async def ping(ctx):
        latencia = round(ctx.bot.latency * 1000)
        await ctx.send(f'Pong, a latência do servidor é de {latencia}ms.')
