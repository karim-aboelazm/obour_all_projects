from rest_framework.generics import (
    ListCreateAPIView,
    get_object_or_404,
    RetrieveAPIView,
    GenericAPIView,
    ListAPIView,
)
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from roads.models import PlaceWay, Road
from roads.serializers import PlaceWaySerializer, RoadSerializer
from rest_framework.pagination import PageNumberPagination
from django.db.models import Q
from rest_framework.decorators import api_view
from django.http import JsonResponse


# Create your views here.
@api_view(["GET"])
def GetRodesFromTo(request, frm, to):
    if request.method == "GET":
        way = PlaceWay.objects.filter(frm=frm, to=to)
        seriailzer = PlaceWaySerializer(way, many=True)
        return Response(data=seriailzer.data, status=status.HTTP_200_OK)
    return Response({"data": "error"}, status=status.HTTP_400_BAD_REQUEST)


class AllRoudes(ListAPIView):
    queryset = PlaceWay.objects.all()
    serializer_class = PlaceWaySerializer


"""class Road(ListAPIView):
    queryset=Road.objects.all()

    serializer_class=RoadSerializer"""


@api_view(["GET"])
def GetRode(request, id):
    if request.method == "GET":
        query = Road.objects.filter(placeWay=id)
        serializer = RoadSerializer(query, many=True)
        return Response(data=serializer.data, status=status.HTTP_200_OK)
    return Response({"data": "error"}, status=status.HTTP_400_BAD_REQUEST)
