# Generated by Django 4.1.7 on 2023-03-11 12:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerce', '0004_alter_accessories_discount_alter_car_discount_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='car',
            name='car_price',
            field=models.DecimalField(decimal_places=3, max_digits=12),
        ),
    ]
