from rest_framework.permissions import IsAuthenticatedOrReadOnly
from rest_framework.response import Response
from rest_framework.views import APIView

from places.models import Place
from posts.models import Post
from .models import Comment
from .serializers import CommentSerializer


class CommentsAPIView(APIView):
    serializer_class = CommentSerializer
    permission_classes = [IsAuthenticatedOrReadOnly]

    def post(self, request, *args, **kwargs):
        place_id = request.data.get('place_id', None)
        comment_id = request.data.get('comment_id', None)
        post_id = request.data.get('post_id', None)
        text = request.data.get('text', None)

        if place_id:
            place = Place.objects.get(id=place_id)
            comment = Comment.objects.create(place=place, text=text, owner=request.user)

        elif comment_id:
            comment = Comment.objects.get(id=comment_id)
            comment = Comment.objects.create(comment=comment, text=text, owner=request.user)

        elif post_id:
            post = Post.objects.get(id=post_id)
            comment = Comment.objects.create(post=post, text=text, owner=request.user)

        return Response(CommentSerializer(comment).data, status=201)

    def get(self, request):
        parent_type = request.query_params.get('parent_type', None)
        parent_id = request.query_params.get('parent_id', None)

        if parent_type == 'place':
            comments = Comment.objects.filter(place__id=parent_id)

        elif parent_type == 'comment':
            comments = Comment.objects.filter(comment__id=parent_id)

        elif parent_type == 'post':
            comments = Comment.objects.filter(post__id=parent_id)
        return Response(CommentSerializer(comments, many=True).data, status=200)
