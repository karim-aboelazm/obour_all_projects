from django.urls import path
from .views import GetMyFavPlace, FavPlace

urlpatterns = [
    path("GetMyFavPlace", GetMyFavPlace.as_view()),
    path("FavActions/<int:pk>", FavPlace.as_view()),
    
]
