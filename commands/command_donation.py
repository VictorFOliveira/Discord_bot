import discord
from discord.ext import commands
import requests
import datetime
from PIL import Image
import qrcode
import io


@commands.command()
async def donate_bitcoin(ctx):
    address = 'bc1qgv6x222qlcjpwyslfsf2cuwtrlyz2986h2s9qz'  

    qr = qrcode.make(f"Bitcoin:{address}")

    
    with io.BytesIO() as image_binary:
        qr.save(image_binary, "PNG")
        image_binary.seek(0)  

        await ctx.send("Aqui está o QR Code para doações em para impulsionar e melhorar e ajudar a contribuir com outros projetos. Bitcoin:", file=discord.File(image_binary, "donate_qr.png"))