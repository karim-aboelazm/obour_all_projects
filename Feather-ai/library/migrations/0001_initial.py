# Generated by Django 3.2.19 on 2023-05-29 22:35

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='CardTemplate',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('template_id', models.IntegerField(unique=True)),
                ('icon', models.ImageField(blank=True, null=True, upload_to='card_icons')),
                ('title', models.CharField(max_length=100)),
                ('description', models.TextField()),
                ('bookmarked', models.BooleanField(default=False)),
            ],
        ),
    ]
