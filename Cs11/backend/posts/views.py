from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters
from rest_framework import generics, status
from rest_framework.pagination import PageNumberPagination
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from places.models import Place
from .models import Post, Attachment, PostContent
from .serializers import (
    PostSerializer,
    AttachmentSerializer,
)


class PostAPIView(generics.ListCreateAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    pagination_class = PageNumberPagination
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['user']

    def post(self, request, *args, **kwargs):
        contents = request.data.get('contents')
        post = Post.objects.create(user=request.user)

        contents = []
        for key, value in request.data.items():
            # Extracting the index number from the key
            index = int(key.split('[')[1].split(']')[0])
            if index >= len(contents):
                contents.append({})
            # Extracting the field name from the key
            field = key.split('[')[2].split(']')[0]
            # Adding the field and value to the corresponding index in the contents list
            if field == 'img':
                contents[index][field] = value
            else:
                contents[index][field] = value

        # Creating the final JSON format

        for content in contents:
            # create post
            content_type = content.get('type', None)
            if content_type == 'image':
                img = content.get('img', None)
                post_content = PostContent.objects.create(img=img, type=content_type, post=post)

            elif content_type == 'place':
                place_id = content.get('place_id', None)
                text = content.get('text', None)
                place = Place.objects.get(id=place_id)
                post_content = PostContent.objects.create(place=place, type=content_type, text=text, post=post)
            else:
                text = content.get('text', None)
                post_content = PostContent.objects.create(type=content_type, post=post, text=text)

        return Response(PostSerializer(post).data, status=status.HTTP_201_CREATED)

    def get(self, request, *args, **kwargs):
        query_param = request.query_params.get('user')
        if query_param == 'me':
            user = request.user
            queryset = self.get_queryset().filter(user=user)
            page = self.paginate_queryset(queryset)
            if page is not None:
                serializer = self.get_serializer(page, many=True)
                return self.get_paginated_response(serializer.data)
            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)

        return self.list(request, *args, **kwargs)


class PostDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializer

    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)


class AttachmentList(generics.CreateAPIView):
    queryset = Attachment.objects.all()
    serializer_class = AttachmentSerializer

    def post(self, request, *args, **kwargs):
        return super().post(request, *args, **kwargs)


class AttachmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Attachment.objects.all()
    serializer_class = AttachmentSerializer

    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)
