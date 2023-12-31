# Generated by Django 4.1.7 on 2023-03-11 12:18

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerce', '0005_alter_car_car_price'),
    ]

    operations = [
        migrations.AlterField(
            model_name='car',
            name='car_price',
            field=models.DecimalField(decimal_places=3, max_digits=9),
        ),
        migrations.AlterField(
            model_name='car',
            name='price_after_discount',
            field=models.DecimalField(blank=True, decimal_places=3, max_digits=9),
        ),
        migrations.CreateModel(
            name='PartsImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='parts_images/')),
                ('part', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='ecommerce.carparts')),
            ],
        ),
        migrations.CreateModel(
            name='CarImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='car_images/')),
                ('car', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='ecommerce.car')),
            ],
        ),
        migrations.CreateModel(
            name='AccessoriesImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='accessories_images/')),
                ('acc', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='ecommerce.accessories')),
            ],
        ),
    ]
