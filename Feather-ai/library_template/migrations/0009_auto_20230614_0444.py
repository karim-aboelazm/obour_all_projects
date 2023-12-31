# Generated by Django 3.2.19 on 2023-06-14 01:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('library_template', '0008_auto_20230613_0144'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='article',
            name='content',
        ),
        migrations.RemoveField(
            model_name='suboutline',
            name='subOutlineDescription',
        ),
        migrations.AddField(
            model_name='article',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, null=True),
        ),
        migrations.AddField(
            model_name='article',
            name='slug',
            field=models.SlugField(blank=True, max_length=100, unique=True),
        ),
        migrations.AddField(
            model_name='article',
            name='title',
            field=models.CharField(blank=True, max_length=100),
        ),
        migrations.AddField(
            model_name='suboutline',
            name='body',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='suboutline',
            name='suboutlines',
            field=models.TextField(blank=True, null=True),
        ),
    ]
