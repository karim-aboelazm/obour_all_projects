from django.db import models

class SkinImagePrediction(models.Model):
    image = models.ImageField(upload_to='skin/')
    classes = models.CharField(max_length=225,null=True,blank=True)
    class Meta:
        verbose_name_plural = 'Skin Image Prediction'
    def __str__(self):
        return self.classes