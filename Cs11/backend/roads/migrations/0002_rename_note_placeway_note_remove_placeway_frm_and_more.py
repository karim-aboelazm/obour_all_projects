# Generated by Django 4.1.3 on 2023-04-29 16:55

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('places', '0003_area'),
        ('roads', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='placeway',
            old_name='Note',
            new_name='note',
        ),
        migrations.RemoveField(
            model_name='placeway',
            name='Frm',
        ),
        migrations.RemoveField(
            model_name='road',
            name='From',
        ),
        migrations.RemoveField(
            model_name='road',
            name='oreder',
        ),
        migrations.RemoveField(
            model_name='road',
            name='to',
        ),
        migrations.AddField(
            model_name='road',
            name='order',
            field=models.IntegerField(default=1, verbose_name='order of transportation'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='placeway',
            name='to',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='places.place'),
        ),
        migrations.AddField(
            model_name='placeway',
            name='frm',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
            preserve_default=False,
        ),
    ]
