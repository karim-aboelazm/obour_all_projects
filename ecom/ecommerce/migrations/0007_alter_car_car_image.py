# Generated by Django 4.1.7 on 2023-03-18 12:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerce', '0006_alter_car_car_price_alter_car_price_after_discount_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='car',
            name='car_image',
            field=models.ImageField(upload_to='cars/'),
        ),
    ]
