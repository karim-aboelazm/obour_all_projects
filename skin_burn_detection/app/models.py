from django.db import models

# Create your models here.
class SkinBurnDegreeseClassification(models.Model):
    skin_image                = models.ImageField(upload_to='skin_process/')
    skin_burn_classification  = models.CharField(max_length=225)
    skin_burn_accuracy        = models.CharField(max_length=225)
    
    class Meta:
        verbose_name_plural = 'Skin Burn Degreese Classification'
        
    def __str__(self):
        return f"Image ( {self.id} ) , it classify to ( {self.skin_burn_classification} ) , with accuracy ( {self.skin_burn_accuracy} % )"

class SkinBurnDegreeseInfo(models.Model):
    title      = models.CharField(max_length=255)
    definition = models.TextField()
    causes     = models.TextField()
    treatment  = models.TextField()
    
    class Meta:
        verbose_name_plural = 'Skin Burn Degreese Info'
        
    def __str__(self):
        return self.title