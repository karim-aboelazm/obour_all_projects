from rest_framework.generics import (
    CreateAPIView,
    GenericAPIView,
    RetrieveUpdateAPIView,
    RetrieveAPIView,
    RetrieveDestroyAPIView,
    ListAPIView,
    ListCreateAPIView,
    DestroyAPIView,
    UpdateAPIView,
    RetrieveUpdateDestroyAPIView,
    get_object_or_404,
)
from rest_framework.response import Response
from rest_framework import permissions
from rest_framework.decorators import api_view
from .models import User
from places.models import Place
from .serializers import (
    SignupSerializer,
    LoginSerializer,
    AddFavoritePlaceSerializer,
    UserSerializer,
)
from places.serializers import PlaceSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework import status


@api_view(["GET"])
def GetUserInfo(request):
    if request.method == "GET":
        user = request.user
        print(user)
        print(user.is_authenticated)
        if user:
            userdate = get_object_or_404(User, user)
            serializer = UserSerializer(userdate)
            return Response(data=serializer.data, status=status.HTTP_200_OK)
        else:
            return Response({"data": "error"}, status=status.HTTP_400_BAD_REQUEST)
    return Response({"data": "error"}, status=status.HTTP_400_BAD_REQUEST)


class SignupView(CreateAPIView):
    serializer_class = SignupSerializer

    def post(self, request, *args, **kwargs):
        user = User.objects.filter(username__iexact=request.data.get("username", ""))
        return self.create(request, *args, **kwargs)


class LoginView(TokenObtainPairView):
    serializer_class = LoginSerializer
