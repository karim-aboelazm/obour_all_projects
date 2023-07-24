# Generated by Django 4.1.7 on 2023-04-07 00:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("islamic", "0020_delete_azkarafterpray_delete_azkarbeforesleep_and_more"),
    ]

    operations = [
        migrations.CreateModel(
            name="TajweedContent",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("video_title", models.CharField(max_length=300)),
                ("video_url", models.URLField()),
                ("video_poster", models.URLField()),
            ],
            options={
                "verbose_name_plural": "Tajweed Content",
            },
        ),
    ]
