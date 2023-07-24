# Generated by Django 4.1.7 on 2023-03-04 12:49

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Accessories',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('acc_type', models.CharField(max_length=200)),
                ('acc_model', models.CharField(max_length=200)),
                ('acc_color', models.CharField(max_length=200)),
                ('country', models.CharField(max_length=200)),
                ('acc_image', models.ImageField(upload_to='accessories/image/')),
                ('acc_price', models.DecimalField(decimal_places=3, max_digits=5)),
                ('discount', models.PositiveIntegerField()),
                ('price_after_discount', models.DecimalField(decimal_places=3, max_digits=5)),
            ],
            options={
                'verbose_name_plural': 'Accessories',
            },
        ),
        migrations.CreateModel(
            name='Car',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('car_type', models.CharField(max_length=200)),
                ('car_model', models.CharField(max_length=200)),
                ('car_color', models.CharField(max_length=200)),
                ('country', models.CharField(max_length=200)),
                ('car_image', models.ImageField(upload_to='car/image/')),
                ('car_is_new', models.BooleanField(default=True)),
                ('car_price', models.DecimalField(decimal_places=3, max_digits=5)),
                ('discount', models.PositiveIntegerField()),
                ('price_after_discount', models.DecimalField(decimal_places=3, max_digits=5)),
            ],
            options={
                'verbose_name_plural': 'Car',
            },
        ),
        migrations.CreateModel(
            name='CarParts',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('car_part_type', models.CharField(max_length=200)),
                ('car_part_model', models.CharField(max_length=200)),
                ('car_part_color', models.CharField(max_length=200)),
                ('country', models.CharField(max_length=200)),
                ('car_part_image', models.ImageField(upload_to='carparts/image/')),
                ('car_part_price', models.DecimalField(decimal_places=3, max_digits=5)),
                ('discount', models.PositiveIntegerField()),
                ('price_after_discount', models.DecimalField(decimal_places=3, max_digits=5)),
            ],
            options={
                'verbose_name_plural': 'CarParts',
            },
        ),
        migrations.CreateModel(
            name='ProjectInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('description', models.TextField()),
                ('motivation', models.TextField()),
                ('problem', models.TextField()),
                ('solution', models.TextField()),
            ],
            options={
                'verbose_name_plural': 'ProjectInfo',
            },
        ),
        migrations.CreateModel(
            name='ProjectTeam',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('image', models.ImageField(upload_to='ProjectTeam/image/')),
                ('email', models.EmailField(max_length=254)),
            ],
            options={
                'verbose_name_plural': 'ProjectTeam',
            },
        ),
    ]