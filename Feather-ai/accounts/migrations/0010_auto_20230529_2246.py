# Generated by Django 3.2.19 on 2023-05-29 19:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0009_user_is_verified'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='profile_image',
        ),
        migrations.AddField(
            model_name='userprofile',
            name='profile_image',
            field=models.ImageField(blank=True, null=True, upload_to='profile_images'),
        ),
    ]
