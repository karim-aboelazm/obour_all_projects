from django.urls import path
from . import api

app_name = 'app'

urlpatterns = [
    path('prediction/', api.SkinApi.as_view(), name='prediction'),
]