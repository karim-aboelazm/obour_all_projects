from django import forms

class TextSummaryForm(forms.Form):
    text_summary = forms.CharField(widget=forms.Textarea)
    
class FilesSummaryForm(forms.Form):
    file_summary = forms.FileField()
    
class UrlSummaryForm(forms.Form):
    url_summary = forms.URLField()

class VideoSummaryForm(forms.Form):
    video_summary = forms.FileField()