# Generated by Django 4.1.7 on 2023-04-05 17:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("islamic", "0016_arkancontent_title"),
    ]

    operations = [
        migrations.CreateModel(
            name="IslamicAdvices",
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
                ("advice", models.TextField()),
            ],
            options={
                "verbose_name_plural": "Islamic Advices",
            },
        ),
    ]
