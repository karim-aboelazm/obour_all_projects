# Generated by Django 4.1.3 on 2023-03-30 16:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('places', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='placegallery',
            name='place',
        ),
    ]
