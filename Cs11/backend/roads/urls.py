from django.urls import path
from roads.views import GetRodesFromTo,AllRoudes,GetRode
urlpatterns=[
    path("form/<int:frm>/to/<int:to>/",GetRodesFromTo),
    path("all-available-rodes",AllRoudes.as_view()),
    path("get-the-transportation-of-rode/<int:id>",GetRode)
]
