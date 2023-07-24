from django.urls import path

from .views import PostAPIView, PostDetail, AttachmentList, AttachmentDetail

urlpatterns = [
    path('post/', PostAPIView.as_view(), name='post_list'),
    path('post/<int:pk>/', PostDetail.as_view(), name='post_detail'),
    path('attachments/', AttachmentList.as_view(), name='attachment_list'),
    path('attachments/<int:pk>/', AttachmentDetail.as_view(), name='attachment_detail'),
]
