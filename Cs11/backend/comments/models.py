from django.db import models

from users.models import User


class Comment(models.Model):
    text = models.TextField()
    place = models.ForeignKey('places.Place', on_delete=models.CASCADE, blank=True, null=True)
    post = models.ForeignKey('posts.Post', on_delete=models.CASCADE, blank=True, null=True)
    comment = models.ForeignKey('self',on_delete=models.SET_NULL, blank=True, null=True, related_name='replies')
    created_at = models.DateTimeField(auto_now_add=True)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.text
