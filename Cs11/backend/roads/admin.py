from django.contrib import admin

# Register your models here.
from roads.models import PlaceWay,Road
admin.site.register((PlaceWay,Road))