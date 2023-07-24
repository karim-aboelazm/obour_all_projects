from django.db import models


class City(models.Model):
    name = models.CharField(max_length=255)
    nick_name = models.CharField(max_length=255)
    main_Image = models.ImageField(upload_to="places")
    area = models.DecimalField(max_digits=10, decimal_places=2)
    location = models.JSONField()
    info = models.TextField()
    location_text = models.CharField(max_length=255)

    def __str__(self):
        return self.name


class PlaceCategory(models.Model):
    name = models.CharField(max_length=255)
    icon = models.ImageField(upload_to="icons")

    def __str__(self):
        return self.name


class Area(models.Model):
    """
    example: Alsalam, Elmarg
    """

    name = models.CharField(max_length=255)
    location = models.JSONField()
    location_text = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.name} "


class Place(models.Model):
    """
    represent historical and visits places in the system
    """

    """
    Place model
    0) city (foreign key)
    1) main_Image
    2) Name
    3) price (if it is a zero then make it free)
    4) category (foreign key)
    5) rate
    6) info
    7) location_text
    8) location (json) (lat, lng)
    9) gallery
    """
    city = models.ForeignKey(City, on_delete=models.CASCADE)
    main_Image = models.ImageField(upload_to="places")
    category = models.ForeignKey(PlaceCategory, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    price = models.IntegerField(default=0)
    rate = models.DecimalField(max_digits=4, decimal_places=2, default=0.0)
    location = models.JSONField()
    info = models.TextField()
    location_text = models.CharField(max_length=255)
    gallery = models.ManyToManyField(
        "PlaceGallery", blank=True, related_name="place_gallery"
    )

    def __str__(self):
        return f"{self.pk} {self.name}"


class PlaceGallery(models.Model):
    # place = models.ForeignKey(Place, on_delete=models.CASCADE)
    image = models.ImageField(upload_to="places")

    def __str__(self):
        return str(self.pk)
