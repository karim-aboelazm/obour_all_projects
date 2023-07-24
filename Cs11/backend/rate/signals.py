from django.db.models.signals import post_save
from django.dispatch import receiver
from rate.models import RatePlace
from places.models import Place
from django.db.models import Sum


@receiver(post_save, sender=RatePlace)
def clac_rate_place(sender, instance, created, **kwargs):
    print(0)
    if created:
        print(1)
        o = Place.objects.get(pk=instance.place.pk)
        if o.rate == 0.0:
            print(3)
            o.rate = instance.rate
            o.save()

        else:
            print(4)
            rated_place = RatePlace.objects.filter(place=instance.place)
            total_rate = rated_place.aggregate(total_rate=Sum("rate"))["total_rate"]
            o = Place.objects.get(pk=instance.place.pk)
            o.rate = total_rate / rated_place.count()
            o.save()
    if not created:
        print(2)
        rated_place = RatePlace.objects.filter(place=instance.place)
        total_rate = rated_place.aggregate(total_rate=Sum("rate"))["total_rate"]
        o = Place.objects.get(pk=instance.place.pk)
        o.rate = total_rate / rated_place.count()
        o.save()
