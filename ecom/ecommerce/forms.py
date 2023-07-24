from django import forms 
from django.contrib.auth.models import User
from ecommerce.models import *
# form-----> forms.form

# form-----> forms.ModelForm

class CustomerRegisterForm(forms.ModelForm):
    username = forms.CharField(widget = forms.TextInput())
    email    = forms.EmailField()
    password = forms.CharField(widget = forms.PasswordInput())
    class Meta:
        model = Customer
        fields = [
            'username',
            'first_name',
            'last_name',
            'password',
            'email',
            'Address'
        ]
    def clean_username(self):
        user_name = self.cleaned_data["username"]
        if User.objects.filter(username = user_name).exists():
            raise forms.ValidationError("Customer with this username is already exists.")
        return user_name

class CustomerLoginForm(forms.Form):
    username = forms.CharField(widget = forms.TextInput())
    password = forms.CharField(widget = forms.PasswordInput())
    def clean_username(self):
        user_name = self.cleaned_data["username"]
        if User.objects.filter(username = user_name).exists():
            pass
        else:
            raise forms.ValidationError("Customer with this username is not exists.")
        return user_name

class CustomerUpdateProfileForm(forms.ModelForm):
    model = Customer
    fields = [
        'first_name',
        'last_name',
        'phone_number',
        'Address',
        'profile'
        ]
        
class CustomerForgetPasswordForm(forms.Form):
    email    = forms.EmailField()
    def clean_email(self):
        user_email = self.cleaned_data["email"]
        if Customer.objects.filter(user__email = user_email).exists():
            pass
        else:
            raise forms.ValidationError("Customer with this email is not exists.")
        return user_email

class CustomerResetPasswordForm(forms.Form):
    new_password    = forms.CharField(widget = forms.PasswordInput())
    new_password_confirmation    = forms.CharField(widget = forms.PasswordInput())
    def clean__confirm_new_password(self):
        user_new_password = self.cleaned_data["new_password"]
        user_new_password_confirmation = self.cleaned_data["new_password_confirmation"]
        if user_new_password != user_new_password_confirmation:
            raise forms.ValidationError("Passwords not Matching ..")
        return new_password_confirmation
         