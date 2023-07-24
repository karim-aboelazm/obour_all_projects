from django.conf.urls import include
from django.urls import path, re_path

from places import views

urlpatterns = [
    path("city/<int:id>/", views.CityAPIView.as_view()),
    path("city/", views.CityAPIListView.as_view()),
    path("category<int:id>/", views.PlaceCategoryAPIView.as_view()),
    path("category/", views.PlaceCategoryAPIListView.as_view()),
    path("<int:id>/", views.PlaceAPIView.as_view()),
    path("", views.PlaceAPIListView.as_view()),
    path("gallery/<int:id>/", views.PlaceGalleryAPIView.as_view()),
    path("gallery/", views.PlaceGalleryAPIListView.as_view()),
    path("search/", views.place_search),
    path("Get-Place-By-City-Id/<int:City_id>", views.Get_Plcaes_By_City_Id),
    path("Get-Place-By-Category-Id/<int:category_id>", views.Get_Plcaes_By_Category_Id),
]
