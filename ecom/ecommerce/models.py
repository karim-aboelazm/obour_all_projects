from django.db import models
from django.contrib.auth.models import User

class Admins(models.Model):
    user          = models.OneToOneField(User,on_delete=models.CASCADE)
    first_name    = models.CharField(max_length=100)     
    last_name     = models.CharField(max_length=100)     
    email         = models.EmailField()
    phone_number  = models.CharField(max_length=100)    
    Address       = models.CharField(max_length=100)
    profile       = models.ImageField(upload_to="admins/")
    class Meta:
            verbose_name_plural ='Admins'
    
    def __str__(self):
        return f"Admin with username : {self.user.username}"

class Customer(models.Model):
    user          = models.OneToOneField(User,on_delete=models.CASCADE)
    first_name    = models.CharField(max_length=100)     
    last_name     = models.CharField(max_length=100)     
    email         = models.EmailField()
    phone_number  = models.CharField(max_length=100)    
    Address       = models.CharField(max_length=100)
    profile       = models.ImageField(upload_to="customer/")
    class Meta:
            verbose_name_plural ='Customer'
    def __str__(self):
        return f"Customer with username : {self.user.username}"

class Car(models.Model):
    car_type                 = models.CharField(max_length=200)
    car_model                = models.CharField(max_length=200)
    car_color                = models.CharField(max_length=200)
    country                  = models.CharField(max_length=200)
    car_image                = models.ImageField(upload_to='cars/')
    Brand                    = models.CharField(max_length=200,null=True,blank=True) 
    Generation               = models.CharField(max_length=200,null=True,blank=True)
    Body_type                = models.CharField(max_length=200,null=True,blank=True)
    Seats                    = models.IntegerField(default=4,null=True,blank=True)
    Doors                    = models.IntegerField(default=4,null=True,blank=True)
    Fuel_type                = models.CharField(max_length=200,null=True,blank=True)
    Power                    = models.CharField(max_length=200,null=True,blank=True)
    Torque                   = models.CharField(max_length=200,null=True,blank=True)
    Length                   = models.CharField(max_length=200,null=True,blank=True)
    Width                    = models.CharField(max_length=200,null=True,blank=True)
    Height                   = models.CharField(max_length=200,null=True,blank=True)
    Assisting_systems        = models.CharField(max_length=200,null=True,blank=True)
    Availablaty	             = models.CharField(max_length=200,choices=(('yes','yes'),('no','no')),null=True,blank=True,default='yes')
    car_is_new               = models.BooleanField(default=True)
    car_price                = models.DecimalField(max_digits=9,decimal_places=3)
    discount                 = models.DecimalField(max_digits=3,decimal_places=1)
    price_after_discount     = models.DecimalField(max_digits=9,decimal_places=3,blank=True)
     # creating slug automaticaly   
    def save(self, *args, **kwargs):
        self.price_after_discount = (self.car_price - self.car_price*self.discount/100)
        super(Car, self).save(*args, **kwargs)
    class Meta:
        verbose_name_plural ='Car'
    
    def __str__(self):
        return self.car_type
    
class ElectricCar(Car):
    Battery = models.CharField(max_length=200)
    Real_range = models.CharField(max_length=200)
    Efficiency = models.CharField(max_length=200)
    Charging = models.CharField(max_length=200)
    class Meta:
        verbose_name_plural ='ElectricCar'
    def __str__(self):
        return self.car_type
    
class Accessories(models.Model):
    acc_type                 = models.CharField(max_length=200)
    acc_model                = models.CharField(max_length=200)
    acc_color                = models.CharField(max_length=200)
    country                  = models.CharField(max_length=200)
    acc_image                = models.ImageField(upload_to='accessories/image/')
    acc_price                = models.DecimalField(max_digits=8,decimal_places=3)
    discount                 =  models.DecimalField(max_digits=3,decimal_places=1)
    price_after_discount     = models.DecimalField(max_digits=8,decimal_places=3,blank=True)
    def save(self, *args, **kwargs):
        self.price_after_discount = (self.acc_price - self.acc_price*self.discount/100)
        super(Accessories, self).save(*args, **kwargs)
    class Meta:
        verbose_name_plural ='Accessories'
    
    def __str__(self):
        return self.acc_type

class CarParts(models.Model):
    car_part_type                 = models.CharField(max_length=200)
    car_part_model                = models.CharField(max_length=200)
    car_part_color                = models.CharField(max_length=200)
    country                  = models.CharField(max_length=200)
    car_part_image                = models.ImageField(upload_to='carparts/image/')
    car_part_price                = models.DecimalField(max_digits=8,decimal_places=3)
    discount                 =  models.DecimalField(max_digits=3,decimal_places=1)
    price_after_discount     = models.DecimalField(max_digits=8,decimal_places=3,blank=True)
    def save(self, *args, **kwargs):
        self.price_after_discount = (self.car_part_price - self.car_part_price*self.discount/100)
        super(CarParts, self).save(*args, **kwargs)
    class Meta:
        verbose_name_plural ='CarParts'
    def __str__(self):
        return self.car_part_type

class ProjectTeam(models.Model):
    name = models.CharField(max_length=255)
    image = models.ImageField(upload_to='ProjectTeam/image/')
    email = models.EmailField()
    class Meta:
        verbose_name_plural ='ProjectTeam'

class ProjectInfo(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    motivation = models.TextField()
    problem = models.TextField()
    solution = models.TextField()
    class Meta:
        verbose_name_plural ='ProjectInfo'
    def __str__(self):
        return self.name

class CarImage(models.Model):
    car = models.ForeignKey(Car,on_delete=models.CASCADE)
    image = models.ImageField(upload_to="car_images/")

    def __str__(self):
        return f"image ({self.id})"

class AccessoriesImage(models.Model):
    acc = models.ForeignKey(Accessories,on_delete=models.CASCADE)
    image = models.ImageField(upload_to="accessories_images/")
    def __str__(self):
        return f"image ({self.id})"

class PartsImage(models.Model):
    part = models.ForeignKey(CarParts,on_delete=models.CASCADE)
    image = models.ImageField(upload_to="parts_images/")
    def __str__(self):
        return f"image ({self.id})"
