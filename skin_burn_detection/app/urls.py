from django.urls import path
from .views import *

app_name = 'app'

urlpatterns = [
    path('', HomePageView.as_view(), name='home'),
    path('prediction/',PredictionPageView.as_view(),name='predict'),
    path('download-report/',DownloadPDF.as_view(),name='download_pdf')
]