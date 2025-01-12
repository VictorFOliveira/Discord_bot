from discord.ext import commands

@commands.command()
async def helper(ctx):
    contato = 'https://t.me/Imvictordev'
    await ctx.send(
        f'Meu telegram do meu chefe para contato é: {contato}, qualquer dúvida ou sugestão é só mandar um mensagem. Ah, o nome dele é Victor.'
    )