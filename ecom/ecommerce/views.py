from django.shortcuts import render,redirect,reverse
from django.urls import reverse_lazy
from django.views.generic import TemplateView,CreateView,View,FormView
from .models import *
from .forms import *
from django.contrib.auth import authenticate , login , logout
from django.contrib.auth.views import PasswordChangeView

class CustomerRegisterView(CreateView):
    template_name="signup.html"
    form_class = CustomerRegisterForm
    success_url = '/'
    def form_valid(self,form):
        username     = form.cleaned_data.get("username")
        email        = form.cleaned_data.get("email")
        password     = form.cleaned_data.get("password")
        first_name   = form.cleaned_data.get("first_name")
        last_name    = form.cleaned_data.get("last_name")
        phone_number = form.cleaned_data.get("phone_number")    
        Address      = form.cleaned_data.get("Address")
        user = User.objects.create_user(
            username=username,
            email=email,
            password=password,
            first_name=first_name,
            last_name=last_name
        )
        form.instance.user = user
        login(self.request,user)
        return super().form_valid(form)

class CustomerLogOutView(View): 
    def get(self,request):
        logout(request)
        return redirect('/login/')  

class CustomerLoginView(FormView):
    template_name = "login.html"
    form_class = CustomerLoginForm
    success_url = '/'
    def form_vaild(self,form):
        username     = form.cleaned_data.get("username")
        password     = form.cleaned_data.get("password")
        usr = authenticate(username=username,password=password)
        if usr is not None and Customer.objects.filter(user=usr).exists():
            login(self.request,usr)
        else:
            return render(self.request,self.template_name,{'form':self.form_class})
        return super().form_valid(form)


class HomePageView(TemplateView):
    template_name = 'home.html'
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["all_cars"] = Car.objects.all().order_by('-id') 
        context["project"] = ProjectInfo.objects.latest('id')
        context['all_parts']= CarParts.objects.all()
        context['all_accs']= Accessories.objects.all()
        return context

class AllCarsPageView(TemplateView):
    template_name = 'all_cars.html'
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["all_cars"] = Car.objects.all().order_by('-id') 
        return context

class OneCarDetail(TemplateView):
    template_name = 'one_car.html'
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["one_car"] = Car.objects.get(id=kwargs['pk'])
        return context


    