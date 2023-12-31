# Generated by Django 4.1.3 on 2023-06-16 20:37

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('places', '0004_alter_place_rate'),
        ('posts', '0004_alter_post_index'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='post',
            name='body',
        ),
        migrations.RemoveField(
            model_name='post',
            name='img',
        ),
        migrations.RemoveField(
            model_name='post',
            name='place',
        ),
        migrations.RemoveField(
            model_name='post',
            name='type',
        ),
        migrations.CreateModel(
            name='PostContent',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(default='post', max_length=255)),
                ('img', models.ImageField(blank=True, null=True, upload_to='posts')),
                ('text', models.TextField(blank=True, null=True)),
                ('place', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='places.place')),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='posts.post')),
            ],
        ),
    ]
