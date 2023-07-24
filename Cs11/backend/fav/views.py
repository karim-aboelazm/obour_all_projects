from fav.serializers import FavPlaceSerializers
from rest_framework.generics import (
    RetrieveAPIView,
    RetrieveUpdateDestroyAPIView,
    DestroyAPIView,
)
from fav.models import FavPlaces
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework import status
from rest_framework.permissions import IsAuthenticated


# Create your views here.
def get_my_fav_places(request):
    pass


def fav_place(request):
    pass


class GetMyFavPlace(RetrieveAPIView):
    def get(self, request):
        self.queryset = FavPlaces.objects.filter(user=self.request.user)
        paginator = PageNumberPagination()
        result_page = paginator.paginate_queryset(self.queryset, request)
        serializer = FavPlaceSerializers(result_page, many=True)
        return paginator.get_paginated_response(serializer.data)


class FavPlace(DestroyAPIView):
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]
    serializer_class = FavPlaceSerializers
    queryset = FavPlaces.objects.all()

    def get_queryset(self):
        queryset = super().get_queryset()
        return queryset.filter(user=self.request.user)

    def post(self, request, pk):
        user, created = FavPlaces.objects.get_or_create(user=self.request.user)

        user.place.add(pk)
        user.save()
        q = FavPlaces.objects.filter(user=user.user)
        serializer = FavPlaceSerializers(q)
        return Response({"created": True}, status=status.HTTP_201_CREATED)

    def delete(self, request, pk):
        user = self.get_queryset().first()
        if user:
            user.place.remove(pk)
            user.save()
            return Response({"deleted": True}, status=status.HTTP_200_OK)
        return Response(
            {"detail": "Object not found."}, status=status.HTTP_404_NOT_FOUND
        )
