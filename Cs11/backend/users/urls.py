from django.urls import path

from users.views import (
    SignupView,
    LoginView,
    GetUserInfo,
)

app_name = "users"

urlpatterns = [
    path("signup/", SignupView.as_view(), name="signup"),
    path("singin/", LoginView.as_view(), name="login"),
    path("get-user-date", GetUserInfo, name="get-user"),
]
