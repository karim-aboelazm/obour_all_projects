from rest_framework.serializers import ModelSerializer
from roads.models import PlaceWay, Road
from places.models import Area, Place


class shortPlaceSerializer(ModelSerializer):
    class Meta:
        model = Place
        fields = (
            "id",
            "name",
        )


class AreaSerializer(ModelSerializer):
    class Meta:
        model = Area
        fields = (
            "id",
            "name",
        )


class PlaceWaySerializer(ModelSerializer):
    frm = AreaSerializer()
    to = shortPlaceSerializer()

    class Meta:
        model = PlaceWay
        fields = "__all__"


class RoadSerializer(ModelSerializer):
    placeWay = PlaceWaySerializer(read_only=True)

    class Meta:
        model = Road
        fields = "__all__"
