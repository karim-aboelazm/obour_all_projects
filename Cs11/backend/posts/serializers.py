from rest_framework import serializers

from comments.models import Comment
from users.serializers import UserSerializer
from .models import Post, Attachment, Love, PostContent


class LoveSerializer(serializers.ModelSerializer):
    class Meta:
        model = Love
        fields = '__all__'


class AttachmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Attachment
        fields = '__all__'


class ContentSerializer(serializers.ModelSerializer):
    class Meta:
        model = PostContent
        fields = '__all__'

    def to_representation(self, instance):
        if instance.type == 'image':
            return {
                'id': instance.id,
                'type': instance.type,
                'img': instance.img.url,
            }
        elif instance.type == 'place':
            return {
                'id': instance.id,
                'type': instance.type,
                'place': {
                    'id': instance.place.id,
                    'name': instance.place.name,
                    'location_text': instance.place.location_text,
                    "main_image": instance.place.main_Image.url,
                },
                'text': instance.text,
            }
        else:
            return {
                'id': instance.id,
                'type': instance.type,
                'text': instance.text,
            }


class PostSerializer(serializers.ModelSerializer):
    likes = serializers.SerializerMethodField()
    user = UserSerializer(read_only=True)
    contents = serializers.SerializerMethodField()
    comments_count = serializers.SerializerMethodField()

    class Meta:
        model = Post
        fields = ['id', 'user', 'contents','comments_count', 'likes', 'created_at', 'updated_at']

    def get_likes(self, obj):
        return obj.likes.count()

    def get_contents(self, obj):
        return ContentSerializer(PostContent.objects.filter(post=obj), many=True).data

    def get_comments_count(self, obj):
        return Comment.objects.filter(post=obj).count()
