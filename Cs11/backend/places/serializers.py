from rest_framework.serializers import ModelSerializer, SerializerMethodField

from places.models import City, PlaceCategory, Place, PlaceGallery


class CitySerializer(ModelSerializer):
    class Meta:
        model = City
        fields = "__all__"


class PlaceCategorySerializer(ModelSerializer):
    class Meta:
        model = PlaceCategory
        fields = "__all__"


class PlaceGallerySerializer(ModelSerializer):
    class Meta:
        model = PlaceGallery
        fields = "__all__"


from fav.models import FavPlaces


class PlaceSerializer(ModelSerializer):
    city = CitySerializer()
    category = PlaceCategorySerializer()
    gallery = PlaceGallerySerializer(many=True)
    is_user_fav_place = SerializerMethodField()

    class Meta:
        model = Place
        fields = "__all__"

    def get_is_user_fav_place(self, obj):
        if self.context.get("request", None):
            user = self.context["request"].user
            is_user_fav_place = FavPlaces.objects.filter(place=obj, user=user).exists()

            return is_user_fav_place
        return False


class PlaceSerializer2(ModelSerializer):
    city = CitySerializer()
    category = PlaceCategorySerializer()
    gallery = PlaceGallerySerializer(many=True)

    class Meta:
        model = Place
        fields = "__all__"
