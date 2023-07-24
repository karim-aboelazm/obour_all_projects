from django.urls import path
from rate.views import rate_place
from .recommention import recommendview

urlpatterns = [
    path("rate_place", rate_place),
    path("recommended", recommendview),
]
