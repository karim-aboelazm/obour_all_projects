from django.db import models
from django.contrib.auth.models import User

class RecentActivity(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    activity_type = models.CharField(max_length=100)
    timestamp = models.DateTimeField(auto_now_add=True)
    details = models.TextField()
    idOfActivity = models.IntegerField( null=True, blank=True)
    
    def __str__(self):
        return f'{self.user.username} - {self.activity_type}'
