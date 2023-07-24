from django.db import models

from places.models import Place, Area


# Create your models here.
class PlaceWay(models.Model):
    frm = models.ForeignKey(Area, on_delete=models.CASCADE)
    to = models.ForeignKey(Place, on_delete=models.CASCADE)

    note = models.CharField(max_length=500, blank=True, null=True)

    def __str__(self) -> str:
        return " From " + str(self.frm) + " TO " + str(self.to)


class RoadChoices(models.TextChoices):
    Toktok = (
        "TokTok",
        "Toctok",
    )
    Bus = (
        "Bus",
        "Bus",
    )
    Train = (
        "Train",
        "Train",
    )
    ManiBus = (
        "ManiBus",
        "ManiBus",
    )
    MicroBus = (
        "MicroBus",
        "MicroBus",
    )
    Metor = "Metor", "Metor"
    Bike = "Bike", "Bike"
    onfoot = "OnFood", "On Food"


class Road(models.Model):
    transportation = models.CharField(max_length=10, choices=RoadChoices.choices)
    order = models.IntegerField("order of transportation")
    placeWay = models.ForeignKey(
        PlaceWay, on_delete=models.PROTECT, related_name="place_way"
    )

    def __str__(self) -> str:
        return f"{self.placeWay}"
