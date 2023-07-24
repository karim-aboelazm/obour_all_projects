from django.urls import path, include
from rest_framework import routers

from .views import CommentsAPIView

app_name = 'comments'

urlpatterns = [

    path('', CommentsAPIView.as_view(), name='comments'),

]
