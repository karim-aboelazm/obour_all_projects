from rest_framework.decorators import (
    api_view,
    authentication_classes,
    permission_classes,
)
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.response import Response
from rest_framework import status
from rate.models import RatePlace
from rate.serializers import RatePlaceSerializer
from django.shortcuts import get_object_or_404
from places.models import Place


@api_view(["POST"])
@authentication_classes([JWTAuthentication])
@permission_classes([IsAuthenticated])
def rate_place(request):
    place_id = request.data.get("place_id", None)
    rate = request.data.get("rate", None)

    place = get_object_or_404(Place, pk=place_id)
    if place_id and rate:
        new_rate, crated = RatePlace.objects.get_or_create(
            place=place, user=request.user, defaults={"rate": rate}
        )
        new_rate.rate = rate
        new_rate.save()
        serializer = RatePlaceSerializer(new_rate)
        return Response(
            {"data": "your data are saved "}, status=status.HTTP_201_CREATED
        )
    return Response(
        {"error": "check if you are send the placeid and the rate "},
        status=status.HTTP_400_BAD_REQUEST,
    )


    