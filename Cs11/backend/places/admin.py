from django.contrib import admin
from places.models import City, PlaceCategory, Place, PlaceGallery, Area

admin.site.register(
    (City, PlaceCategory, Place, PlaceGallery, Area)
)

