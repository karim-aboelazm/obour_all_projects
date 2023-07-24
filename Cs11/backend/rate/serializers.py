from rest_framework.serializers import ModelSerializer
from rate.models import RatePlace
from users.serializers import UserSerializer


class RatePlaceSerializer(ModelSerializer):
    
    

    class Meta:
        model = RatePlace
        fields = "__all__"
        depth=1
