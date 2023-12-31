# Generated by Django 3.2.19 on 2023-06-01 06:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('library', '0006_cardtemplate_additional_photo'),
    ]

    operations = [
        migrations.AddField(
            model_name='cardtemplate',
            name='category',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='cardtemplate',
            name='additional_photo',
            field=models.FileField(blank=True, null=True, upload_to='photos/'),
        ),
    ]
