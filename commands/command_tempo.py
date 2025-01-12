import requests
from discord.ext import commands



@commands.command()
async def tempo(ctx, city: str):
    api_key = 'your_time_token_here'
    base_url = "your_url_here"
    try:
        response = requests.get(base_url)
        data = response.json()

        if data.get("cod") != 200: 
            await ctx.send(
                f"Erro ao obter dados: {data.get('message', 'Cidade não encontrada.')}"
            )
            return

        if 'main' not in data:
            await ctx.send(
                "Não foi possível obter a previsão do tempo. Tente novamente mais tarde."
            )
            return

        main = data["main"]
        weather = data["weather"][0]
        temperature = main["temp"]
        description = weather["description"]

        await ctx.send(
            f"A previsão do tempo em {city} é {temperature}°C com {description}."
        )

    except requests.exceptions.RequestException as e:
        await ctx.send(
            f"Ocorreu um erro ao fazer a requisição para a API: {str(e)}")