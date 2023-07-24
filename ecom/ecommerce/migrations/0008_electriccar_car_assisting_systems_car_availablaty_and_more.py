# Generated by Django 4.2 on 2023-04-13 14:55

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("ecommerce", "0007_alter_car_car_image"),
    ]

    operations = [
        migrations.CreateModel(
            name="ElectricCar",
            fields=[
                (
                    "car_ptr",
                    models.OneToOneField(
                        auto_created=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        parent_link=True,
                        primary_key=True,
                        serialize=False,
                        to="ecommerce.car",
                    ),
                ),
                ("Battery", models.CharField(max_length=200)),
                ("Real_range", models.CharField(max_length=200)),
                ("Efficiency", models.CharField(max_length=200)),
                ("Charging", models.CharField(max_length=200)),
            ],
            options={
                "verbose_name_plural": "ElectricCar",
            },
            bases=("ecommerce.car",),
        ),
        migrations.AddField(
            model_name="car",
            name="Assisting_systems",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Availablaty",
            field=models.CharField(
                blank=True,
                choices=[("yes", "yes"), ("no", "no")],
                default="yes",
                max_length=200,
                null=True,
            ),
        ),
        migrations.AddField(
            model_name="car",
            name="Body_type",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Brand",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Doors",
            field=models.IntegerField(blank=True, default=4, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Fuel_type",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Generation",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Height",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Length",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Power",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Seats",
            field=models.IntegerField(blank=True, default=4, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Torque",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name="car",
            name="Width",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
