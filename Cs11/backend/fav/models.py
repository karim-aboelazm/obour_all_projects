from django.db import models
from places.models import Place
from users.models import User


# Create your models here.
class FavPlaces(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    place = models.ManyToManyField(Place, null=True, blank=True, default=None)

    def __str__(self) -> str:
        return f"{self.user.pk} {self.user.name}"
        
