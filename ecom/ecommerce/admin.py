from django.contrib import admin
from .models import *

our_model = [Car,Accessories,CarParts,ProjectTeam,
             ProjectInfo,CarImage,AccessoriesImage,
             PartsImage,ElectricCar,Admins,Customer]

for mod in our_model:
    admin.site.register(mod)