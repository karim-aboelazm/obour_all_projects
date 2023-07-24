from django import forms
from .models import SkinBurnDegreeseClassification

class SkinBurnDegreeseClassificationForm(forms.ModelForm):
    class Meta:
        model = SkinBurnDegreeseClassification
        fields = ['skin_image']