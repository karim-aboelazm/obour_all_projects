from rest_framework import generics
from rest_framework.decorators import api_view
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from places.models import City, PlaceCategory, Place, PlaceGallery
from places.serializers import (
    CitySerializer,
    PlaceCategorySerializer,
    PlaceSerializer,
    PlaceGallerySerializer,
)
from rest_framework_simplejwt.authentication import JWTAuthentication


class CityAPIView(generics.GenericAPIView):
    serializer_class = CitySerializer
    authentication_classes = [JWTAuthentication]

    permission_classes = [IsAuthenticated]

    def get(self, request, id, format=None):
        try:
            item = City.objects.get(pk=id)
            serializer = CitySerializer(item)
            return Response(serializer.data)
        except City.DoesNotExist:
            return Response(status=404)


class CityAPIListView(generics.GenericAPIView):
    serializer_class = CitySerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, format=None):
        items = City.objects.order_by("pk")
        paginator = PageNumberPagination()
        result_page = paginator.paginate_queryset(items, request)
        serializer = CitySerializer(result_page, many=True)
        return paginator.get_paginated_response(serializer.data)


class PlaceCategoryAPIView(generics.GenericAPIView):
    serializer_class = PlaceCategorySerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, id, format=None):
        try:
            item = PlaceCategory.objects.get(pk=id)
            serializer = PlaceCategorySerializer(item)
            return Response(serializer.data)
        except PlaceCategory.DoesNotExist:
            return Response(status=404)


class PlaceCategoryAPIListView(generics.GenericAPIView):
    serializer_class = PlaceCategorySerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, format=None):
        items = PlaceCategory.objects.order_by("pk")
        paginator = PageNumberPagination()
        result_page = paginator.paginate_queryset(items, request)
        serializer = PlaceCategorySerializer(result_page, many=True)
        return paginator.get_paginated_response(serializer.data)


class PlaceAPIView(generics.GenericAPIView):
    serializer_class = PlaceSerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, id, format=None):
        try:
            item = Place.objects.get(pk=id)

            serializer = PlaceSerializer(item, context={"request": request})

            return Response(serializer.data)
        except Place.DoesNotExist:
            return Response(status=404)


class PlaceAPIListView(generics.GenericAPIView):
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    serializer_class = PlaceSerializer

    def get(self, request, format=None):
        items = Place.objects.order_by("pk")
        paginator = PageNumberPagination()
        result_page = paginator.paginate_queryset(items, request)
        serializer = PlaceSerializer(
            result_page, many=True, context={"request": request}
        )
        return paginator.get_paginated_response(serializer.data)


class PlaceGalleryAPIView(generics.GenericAPIView):
    serializer_class = PlaceGallerySerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, id, format=None):
        try:
            item = PlaceGallery.objects.get(pk=id)
            serializer = PlaceGallerySerializer(item)
            return Response(serializer.data)
        except PlaceGallery.DoesNotExist:
            return Response(status=404)


class PlaceGalleryAPIListView(generics.GenericAPIView):
    serializer_class = PlaceGallerySerializer
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, format=None):
        items = PlaceGallery.objects.order_by("pk")
        paginator = PageNumberPagination()
        result_page = paginator.paginate_queryset(items, request)
        serializer = PlaceGallerySerializer(
            result_page, many=True, context={"request": request}
        )
        return paginator.get_paginated_response(serializer.data)


@api_view(["GET"])
def place_search(request):
    name = request.GET.get("name")
    if name:
        query = Place.objects.filter(name__icontains=name)
        print(query)

        serializer = PlaceSerializer(
            instance=query, many=True, context={"request": request}
        )
        return Response(serializer.data, status=200)
    return Response({"data": "not found"}, status=404)


@api_view(["GET"])
def Get_Plcaes_By_City_Id(request, City_id):
    query = Place.objects.filter(city=City_id)
    serializer = PlaceSerializer(query, many=True, context={"request": request})
    return Response(serializer.data, status=200)


@api_view(["GET"])
def Get_Plcaes_By_Category_Id(request, category_id):
    query = Place.objects.filter(category=category_id)
    serializer = PlaceSerializer(query, many=True, context={"request": request})
    return Response(serializer.data, status=200)
