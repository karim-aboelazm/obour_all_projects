from .models import *
from rest_framework import serializers


class SkinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = SkinImagePrediction
        fields = ['image']

class SkingetSerializer(serializers.ModelSerializer):
    class Meta:
        model = SkinImagePrediction
        fields = ['classes']